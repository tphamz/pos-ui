# Offline Functionality Testing Guide

This guide documents how to verify that all CRUD operations work correctly without network connectivity.

## Overview

The POS app implements an offline-first architecture where:
- All data operations save to local SQLite database immediately
- Changes are queued for sync to the server
- App works fully offline, syncing when network is available

## Test Coverage

Comprehensive tests have been created in `test/services/offline_crud_test.dart` that verify:

### ✅ Product CRUD Operations
- **Create**: Products can be created offline and saved to local DB
- **Read**: Products can be read from local DB without network
- **Update**: Products can be updated offline
- **Delete**: Products can be deleted offline

### ✅ Staff CRUD Operations
- **Create**: Staff can be created offline and saved to local DB
- **Read**: Staff can be read from local DB without network
- **Update**: Staff can be updated offline
- **Delete**: Staff can be deleted offline

### ✅ Table CRUD Operations
- **Create**: Tables can be created offline and saved to local DB
- **Read**: Tables can be read from local DB without network
- **Update**: Tables can be updated offline
- **Delete**: Tables can be deleted offline

### ✅ Ticket CRUD Operations
- **Create**: Tickets can be created offline and saved to local DB
- **Read**: Tickets can be read from local DB without network
- **Update**: Tickets can be updated offline (e.g., adding items)
- **Delete**: Tickets can be deleted offline

### ✅ Sync Queue Verification
- Sync queue items are created for all operations
- Queue items have correct operation type (create/update/delete)
- Queue items have correct entity type (product/staff/table/ticket)
- Queue items are marked as 'pending' status

## Running Tests

```bash
# Run all offline CRUD tests
flutter test test/services/offline_crud_test.dart

# Run with verbose output
flutter test test/services/offline_crud_test.dart --reporter expanded

# Run specific test group
flutter test test/services/offline_crud_test.dart --name "Product CRUD"
```

## Manual Testing Steps

### 1. Test Product Operations Offline

1. **Turn off network** (WiFi/Cellular)
2. **Open app** - Should load from local DB
3. **Create a product**:
   - Go to Products tab → Edit Mode ON
   - Tap "Add Product"
   - Fill in name, price, category
   - Tap "Add"
   - ✅ Product should appear immediately in the list

4. **Read products**:
   - Products list should show all products from local DB
   - ✅ Should work without network

5. **Update a product**:
   - Tap edit icon on a product
   - Change name or price
   - Tap "Save"
   - ✅ Changes should appear immediately

6. **Delete a product**:
   - Tap delete (X) icon on a product
   - Confirm deletion
   - ✅ Product should disappear immediately

### 2. Test Staff Operations Offline

1. **Turn off network**
2. **Go to Staff tab** → Edit Mode ON
3. **Create staff**:
   - Tap "Add Staff"
   - Fill in name, role
   - Tap "Add"
   - ✅ Staff should appear immediately

4. **Update staff**:
   - Tap edit icon on staff
   - Change name or role
   - Tap "Save"
   - ✅ Changes should appear immediately

5. **Delete staff**:
   - Tap delete (X) icon on staff
   - Confirm deletion
   - ✅ Staff should disappear immediately

### 3. Test Table Operations Offline

1. **Turn off network**
2. **Go to Tables tab** → Edit Mode ON
3. **Create table**:
   - Tap "Add Table"
   - Fill in number, capacity
   - Tap "Add"
   - ✅ Table should appear immediately

4. **Update table**:
   - Tap edit icon on table
   - Change capacity or status
   - Tap "Save"
   - ✅ Changes should appear immediately

5. **Delete table**:
   - Tap delete (X) icon on table
   - Confirm deletion
   - ✅ Table should disappear immediately

### 4. Test Ticket Operations Offline

1. **Turn off network**
2. **Create a ticket**:
   - Tap "New Service/Order" button
   - ✅ Ticket should be created immediately

3. **Add items to ticket**:
   - Tap on products to add to ticket
   - ✅ Items should appear in ticket panel immediately

4. **Update ticket**:
   - Change item quantity
   - Add discount to item
   - ✅ Changes should save locally immediately

5. **Close ticket**:
   - Tap "Close" button
   - Select reason ("User already paid" or "Delete the ticket")
   - Confirm
   - ✅ Ticket status should update immediately

### 5. Verify Sync Queue

1. **After performing offline operations**, verify sync queue:
   - All create/update/delete operations should be queued
   - Queue items should have status 'pending'

2. **Turn network back on**:
   - App should automatically sync pending items
   - Queue items should move to 'synced' status and be removed

## Expected Behavior

### ✅ What Should Work Offline

- ✅ Create products, staff, tables, tickets
- ✅ Read/list all entities from local DB
- ✅ Update entities
- ✅ Delete entities
- ✅ Add items to tickets
- ✅ Update ticket items (quantity, discount)
- ✅ Assign staff/table to tickets
- ✅ Close/delete tickets
- ✅ All UI interactions should be instant (no network delays)

### ❌ What Should NOT Work Offline

- ❌ Initial data sync (requires network on first login)
- ❌ Syncing to server (will queue and sync when online)

## Database Verification

You can verify data is in local DB by:

1. **Check local DB file** (for debugging):
   - File location: `[App Documents]/pos_local.db`
   - Use SQLite browser to inspect tables

2. **Check sync queue**:
   - All pending operations should be in `SyncQueue` table
   - Status should be 'pending' for unsynced items

## Troubleshooting

### Issue: Data not appearing after offline create

**Solution**: Check that:
- Data was saved to local DB (`LocalProducts`, `LocalStaff`, etc.)
- Sync queue item was created
- UI is reading from local DB (not API)

### Issue: Sync not happening when network returns

**Solution**: Check that:
- `SyncManager` is initialized
- Connectivity listener is working
- Sync queue has pending items
- Network connectivity is actually available

### Issue: Duplicate entries after sync

**Solution**: Check that:
- IDs are properly generated (UUIDs)
- Conflict resolution is working (insertOnConflictUpdate)
- Sync queue is properly cleaned up after sync

## Success Criteria

All offline functionality is verified when:

1. ✅ All CRUD operations work without network
2. ✅ Data persists across app restarts
3. ✅ Sync queue is properly populated
4. ✅ Data syncs to server when network returns
5. ✅ No data loss during offline operations
