---
title: Offline Inspection Strategy
description: Offline data handling strategy for mobile safety inspections
author: MobileForge AI
version: 1.0
date: 2026-04-14
project_code: MOBILE-SAFETY-INSPECTION
platform: mobile
---

# Offline Inspection Strategy

## Overview

Field inspectors often work in areas with limited or no connectivity. This document outlines the offline-first strategy for the mobile safety inspection workflow.

## Offline Architecture

### Core Principles

1. **Local-First**: All data written to local storage before any network operation
2. **Graceful Degradation**: Full functionality available offline
3. **Background Sync**: Automatic sync when connectivity returns
4. **Conflict Resolution**: Transparent handling of sync conflicts

### Data Flow

```
┌─────────────────────────────────────────────────────────────┐
│                     Offline Data Flow                        │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  User Action                                                 │
│       │                                                      │
│       ▼                                                      │
│  ┌─────────────────┐                                         │
│  │ Save to Local   │  ◄── Immediate write                   │
│  │ Storage         │                                         │
│  └────────┬────────┘                                         │
│           │                                                  │
│           ▼                                                  │
│  ┌─────────────────┐                                         │
│  │ Add to Sync     │  ◄── Queue for sync                     │
│  │ Queue           │                                         │
│  └────────┬────────┘                                         │
│           │                                                  │
│           ▼                                                  │
│  ┌─────────────────┐                                         │
│  │ Show Success    │  ◄── Immediate user feedback            │
│  │ to User         │                                         │
│  └─────────────────┘                                         │
│                                                              │
│           (Background when online)                           │
│           │                                                  │
│           ▼                                                  │
│  ┌─────────────────┐                                         │
│  │ Sync to Backend │  ◄── When connectivity available       │
│  │                 │                                         │
│  └────────┬────────┘                                         │
│           │                                                  │
│           ▼                                                  │
│  ┌─────────────────┐                                         │
│  │ Update Sync     │  ◄── Mark as synced                     │
│  │ Status          │                                         │
│  └─────────────────┘                                         │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

## Local Storage Implementation

### AsyncStorage Keys

```typescript
const STORAGE_KEYS = {
  // Inspection drafts (in-progress)
  INSPECTION_DRAFT: 'inspection_draft_',
  
  // Completed inspections pending sync
  INSPECTION_COMPLETE: 'inspection_complete_',
  
  // Pending photo uploads
  PENDING_PHOTOS: 'pending_photos',
  
  // Sync queue
  SYNC_QUEUE: 'sync_queue',
  
  // Last sync timestamp
  LAST_SYNC: 'last_sync_timestamp',
  
  // User session
  USER_SESSION: 'user_session',
};
```

### Inspection Draft Storage

```typescript
interface InspectionDraft {
  id: string;
  inspectionId: string;
  data: Inspection;
  createdAt: string;
  updatedAt: string;
  syncStatus: 'pending' | 'syncing' | 'failed';
}

// Save draft
const saveDraft = async (draft: InspectionDraft) => {
  const key = `${STORAGE_KEYS.INSPECTION_DRAFT}${draft.id}`;
  await AsyncStorage.setItem(key, JSON.stringify(draft));
  await addToSyncQueue(draft.id, 'draft');
};

// Load draft
const loadDraft = async (id: string): Promise<InspectionDraft | null> => {
  const key = `${STORAGE_KEYS.INSPECTION_DRAFT}${id}`;
  const data = await AsyncStorage.getItem(key);
  return data ? JSON.parse(data) : null;
};
```

### Photo Queue Management

```typescript
interface PendingPhoto {
  id: string;
  inspectionId: string;
  itemId: string;
  localUri: string;
  compressedUri?: string;
  timestamp: string;
  syncStatus: 'pending' | 'uploading' | 'failed';
  retryCount: number;
}

const addPendingPhoto = async (photo: PendingPhoto) => {
  const pending = await getPendingPhotos();
  pending.push(photo);
  await AsyncStorage.setItem(STORAGE_KEYS.PENDING_PHOTOS, JSON.stringify(pending));
};

const getPendingPhotos = async (): Promise<PendingPhoto[]> => {
  const data = await AsyncStorage.getItem(STORAGE_KEYS.PENDING_PHOTOS);
  return data ? JSON.parse(data) : [];
};
```

## Sync Service

### Sync Queue Processing

```typescript
class SyncService {
  private isProcessing = false;
  
  async processQueue() {
    if (this.isProcessing || !navigator.onLine) return;
    
    this.isProcessing = true;
    const queue = await this.getSyncQueue();
    
    for (const item of queue) {
      try {
        await this.syncItem(item);
        await this.removeFromQueue(item.id);
      } catch (error) {
        await this.handleSyncError(item, error);
      }
    }
    
    this.isProcessing = false;
  }
  
  private async syncItem(item: SyncQueueItem) {
    switch (item.type) {
      case 'inspection':
        await this.syncInspection(item.data);
        break;
      case 'photo':
        await this.syncPhoto(item.data);
        break;
      case 'nonconformance':
        await this.syncNonConformance(item.data);
        break;
    }
  }
}
```

### Connectivity Detection

```typescript
import NetInfo from '@react-native-community/netinfo';

const watchConnectivity = (callback: (isOnline: boolean) => void) => {
  const unsubscribe = NetInfo.addEventListener(state => {
    callback(state.isConnected ?? false);
  });
  return unsubscribe;
};

// Auto-sync when connectivity returns
watchConnectivity(async (isOnline) => {
  if (isOnline) {
    await syncService.processQueue();
  }
});
```

## Conflict Resolution

### Strategy: Last-Write-Wins

```typescript
const resolveConflict = async (
  local: Inspection,
  server: Inspection
): Promise<Inspection> => {
  const localTime = new Date(local.updatedAt).getTime();
  const serverTime = new Date(server.updatedAt).getTime();
  
  if (localTime > serverTime) {
    // Local is newer - push to server
    return local;
  } else {
    // Server is newer - update local
    await saveInspectionToLocal(server);
    return server;
  }
};
```

### Conflict Types

| Type | Handling |
|------|----------|
| Same inspection edited on multiple devices | Last-write-wins based on timestamp |
| Photo uploaded but inspection deleted | Delete orphaned photos |
| Non-conformance reported offline multiple times | Create duplicates with same ID |

## Storage Management

### Cleanup Rules

1. **Completed Inspections**: Purge after 30 days if synced
2. **Failed Sync Items**: Keep for manual review
3. **Photos**: Limit local cache to 100MB
4. **Drafts**: Purge after 7 days if never synced

### Storage Quotas

```typescript
const STORAGE_LIMITS = {
  maxInspectionDrafts: 50,
  maxPendingPhotos: 200,
  maxLocalCacheMB: 100,
  draftRetentionDays: 7,
  completedRetentionDays: 30,
};
```

### Auto-Cleanup Implementation

```typescript
const cleanupOldData = async () => {
  const now = Date.now();
  const draftRetention = 7 * 24 * 60 * 60 * 1000;
  const completedRetention = 30 * 24 * 60 * 60 * 1000;
  
  // Clean old drafts
  const drafts = await getAllDrafts();
  for (const draft of drafts) {
    if (now - new Date(draft.updatedAt).getTime() > draftRetention) {
      await AsyncStorage.removeItem(`inspection_draft_${draft.id}`);
    }
  }
  
  // Clean old completed inspections
  const completed = await getCompletedInspections();
  for (const inspection of completed) {
    if (now - new Date(inspection.completedAt).getTime() > completedRetention) {
      await AsyncStorage.removeItem(`inspection_complete_${inspection.id}`);
    }
  }
};
```

## Performance Optimization

### Photo Compression

```typescript
const compressPhotoForUpload = async (uri: string): Promise<string> => {
  const compressed = await ImageManipulator.manipulateAsync(
    uri,
    [
      { resize: { width: 1200 } }, // Max width
    ],
    {
      compress: 0.7, // 70% quality
      format: ImageManipulator.SaveFormat.JPEG,
    }
  );
  return compressed.uri;
};
```

### Batch Operations

```typescript
// Batch sync inspections when possible
const batchSync = async (inspections: Inspection[]) => {
  const response = await api.post('/inspections/batch', {
    inspections,
  });
  return response.data;
};
```

---

**Document Version**: 1.0
**Last Updated**: 2026-04-14
