/** Proposed UI contracts derived from Chapter 2; integrate with validated API schemas later. */
export type KhaanaGoRole = 'Customer' | 'Rider' | 'Vendor' | 'Admin' | 'Shared';
export type ScreenKind = 'Screen' | 'Overlay' | 'Layout set';
export type ScreenPriority = 'P1' | 'P2' | 'P3';
export type CapacityState = 'Available' | 'Limited' | 'Full' | 'Closed';
export type OrderStatus = 'New' | 'Preparing' | 'Ready' | 'Handed Over' | 'Picked up' | 'Delivered' | 'Cancelled';
export type DeliveryMode = 'Pooled' | 'Express';
export interface ScreenDescriptor {
  id: string;
  title: string;
  role: KhaanaGoRole;
  kind: ScreenKind;
  section: string;
  priority: ScreenPriority;
  epic: string;
  story: string;
  requirements: string;
}
export interface OrderLine { itemId: string; quantity: number; unitPrice: number; customization?: Record<string, unknown>; }
export interface CapacitySlot { id: string; day: string; startsAt: string; endsAt: string; state: CapacityState; remainingUnits: number; }
export interface CustomerOrder { id: string; vendorId: string; lines: OrderLine[]; slotId: string; deliveryMode: DeliveryMode; status: OrderStatus; }
