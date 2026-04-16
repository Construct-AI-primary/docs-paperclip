---
title: Mobile Inspection Device Testing
description: Device compatibility and testing strategy for mobile safety inspections
author: MobileForge AI
version: 1.0
date: 2026-04-14
project_code: MOBILE-SAFETY-INSPECTION
platform: mobile
---

# Mobile Inspection Device Testing

## Overview

This document outlines the testing strategy for the mobile safety inspection app, including device compatibility, offline scenarios, and performance testing.

## Device Compatibility Matrix

### Supported Devices

| Device Category | iOS | Android | Notes |
|-----------------|-----|---------|-------|
| Flagship | iPhone 14+, Pixel 7+ | ✅ Supported | Full feature support |
| Mid-range | iPhone 12-13, Pixel 5-6 | ✅ Supported | Minor UI adjustments |
| Budget | iPhone X, older Android | ⚠️ Limited | GPS may be less accurate |
| Tablet | iPad, Android tablets | ⚠️ Tested | Layout adjustments needed |

### OS Requirements

| Platform | Minimum Version | Recommended |
|----------|----------------|-------------|
| iOS | 14.0 | 16.0+ |
| Android | 8.0 (API 26) | 12.0+ |

## Testing Categories

### 1. Unit Tests

```typescript
// Example: ChecklistItem.test.tsx
describe('ChecklistItem', () => {
  it('should toggle completion status', () => {
    const wrapper = mount(<ChecklistItem item={mockItem} />);
    wrapper.find('Checkbox').prop('onToggle')();
    expect(wrapper.state('isCompleted')).toBe(true);
  });
  
  it('should save notes on blur', () => {
    const saveNotes = jest.fn();
    const wrapper = mount(
      <ChecklistItem item={mockItem} onSaveNotes={saveNotes} />
    );
    wrapper.find('NotesInput').prop('onBlur')('Test notes');
    expect(saveNotes).toHaveBeenCalledWith('Test notes');
  });
});
```

### 2. Integration Tests

```typescript
// Example: InspectionService.integration.test.ts
describe('InspectionService', () => {
  beforeEach(() => {
    AsyncStorage.clear();
  });
  
  it('should save inspection locally first', async () => {
    const inspection = createMockInspection();
    await inspectionService.saveInspection(inspection);
    
    const saved = await inspectionService.getInspection(inspection.id);
    expect(saved).toEqual(inspection);
  });
  
  it('should sync when online', async () => {
    // Mock online status
    mockOnlineStatus(true);
    
    const inspection = createMockInspection();
    await inspectionService.saveInspection(inspection);
    
    // Wait for sync
    await waitFor(() => {
      expect(api.post).toHaveBeenCalled();
    });
  });
});
```

### 3. E2E Tests (Detox)

```typescript
// Example: inspectionWorkflow.test.js
describe('Inspection Workflow E2E', () => {
  beforeEach(async () => {
    await device.reloadReactNative();
    await openApp();
  });
  
  it('should complete full inspection flow', async () => {
    // Navigate to schedule
    await element(by.id('scheduleTab')).tap();
    await element(by.id('inspection-1')).tap();
    
    // Start inspection
    await element(by.id('startInspection')).tap();
    
    // Complete items
    for (let i = 0; i < 5; i++) {
      await element(by.id(`checklistItem-${i}`)).tap();
    }
    
    // Add photo
    await element(by.id('addPhoto')).tap();
    await element(by.id('captureButton')).tap();
    await element(by.id('confirmPhoto')).tap();
    
    // Complete inspection
    await element(by.id('completeInspection')).tap();
    
    // Verify success
    await expect(element(by.id('successMessage'))).toBeVisible();
  });
  
  it('should work offline', async () => {
    // Enable airplane mode
    await device.setAirplaneMode(true);
    
    // Complete inspection offline
    await element(by.id('inspection-1')).tap();
    await element(by.id('startInspection')).tap();
    await element(by.id('checklistItem-0')).tap();
    await element(by.id('completeInspection')).tap();
    
    // Verify stored locally
    await expect(element(by.id('syncPending'))).toBeVisible();
  });
});
```

## Offline Testing

### Test Scenarios

| Scenario | Expected Behavior | Test Method |
|----------|------------------|-------------|
| Complete inspection offline | Saves locally, shows sync pending | E2E |
| App killed mid-inspection | Draft preserved | Manual |
| Photo capture offline | Stores locally | E2E |
| Multiple offline inspections | All queued | Integration |
| Go online after 24h offline | All sync successfully | Integration |
| Conflict resolution | Last-write-wins | Unit |

### Offline Test Environment

```bash
# iOS Simulator - Enable airplane mode
xcrun simctl boot "iPhone 14"
xcrun simctl set_airplane_mode on "iPhone 14"

# Android Emulator
adb shell am broadcast -a android.intent.action.AIRPLANE_MODE
```

## Performance Testing

### Benchmarks

| Metric | Target | Critical |
|--------|--------|----------|
| App cold start | < 3s | 5s |
| Screen transition | < 200ms | 500ms |
| Photo capture | < 500ms | 2s |
| Photo compression | < 1s | 3s |
| Local save | < 100ms | 500ms |
| Inspection load | < 1s | 2s |
| GPS lock | < 5s | 15s |

### Performance Test Script

```typescript
describe('Performance Tests', () => {
  it('should load inspection list under 1 second', async () => {
    const start = Date.now();
    await inspectionService.getScheduledInspections();
    const duration = Date.now() - start;
    
    expect(duration).toBeLessThan(1000);
  });
  
  it('should compress photo under 1 second', async () => {
    const photoUri = createLargeTestPhoto();
    const start = Date.now();
    await compressPhoto(photoUri);
    const duration = Date.now() - start;
    
    expect(duration).toBeLessThan(1000);
  });
});
```

## Camera Testing

### Test Scenarios

| Scenario | iOS | Android |
|----------|-----|---------|
| Front camera | ✅ | ✅ |
| Rear camera | ✅ | ✅ |
| Flash control | ✅ | ✅ |
| Focus tap | ✅ | ✅ |
| Photo metadata | ✅ | ✅ |
| Permission denied | ✅ | ✅ |

## GPS Testing

### Test Locations

| Location Type | Accuracy Target | Test Method |
|---------------|----------------|-------------|
| Open outdoor | < 5m | Manual with GPS |
| Urban outdoor | < 15m | Manual |
| Indoor | N/A | Manual (fallback) |
| Underground | N/A | Manual (fallback) |

### GPS Mock Testing

```typescript
jest.mock('expo-location', () => ({
  getCurrentPositionAsync: jest.fn(({ accuracy }) => {
    if (accuracy === Location.Accuracy.High) {
      return Promise.resolve({
        coords: { latitude: 40.7128, longitude: -74.0060 },
      });
    }
    return Promise.resolve({
      coords: { latitude: 40.71, longitude: -74.01 },
    });
  }),
}));
```

## Device Fragmentation Testing

### Screen Size Matrix

| Category | Width | Height | iOS | Android |
|----------|-------|--------|-----|---------|
| Small | < 360px | < 640px | SE, 8 | Pixel 4a |
| Medium | 360-420px | 640-840px | iPhone 12-14 | Pixel 5-6 |
| Large | 420-600px | 840-1000px | iPhone Plus | Pixel 7 |
| Tablet | > 600px | > 1000px | iPad | Tab S series |

### Orientation Testing

- [ ] Portrait mode (all devices)
- [ ] Landscape mode (tablets)
- [ ] Rotation mid-inspection
- [ ] Split-screen (tablets)

---

**Document Version**: 1.0
**Last Updated**: 2026-04-14
