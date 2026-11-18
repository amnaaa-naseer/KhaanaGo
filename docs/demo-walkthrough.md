# Demo walkthrough

Click through one order from the customer, the kitchen, the rider, and the admin. Password for every account is `password12`.

Start the mock API first, then the four apps. Sign in again if you restart the API. Sessions live in memory and disappear on restart.

| App | Command | Address |
| --- | --- | --- |
| Mock API | `node server.js` from `services/mock-api` | http://127.0.0.1:8787 |
| Customer | `flutter run -d chrome --web-port=7357 --web-hostname=127.0.0.1` from `apps/customer_flutter` | the Chrome window Flutter opens |
| Vendor | `npm run dev` from `apps/vendor_portal` | http://localhost:5173 |
| Rider | `flutter run -d web-server --web-port=7358` from `apps/rider_flutter`, then open the printed URL | http://127.0.0.1:7358 |
| Admin | `npm run dev` from `apps/admin_portal` | http://localhost:5174 |

| Who | Account |
| --- | --- |
| Customer | `03001234567` |
| Kitchen owner | `owner@bakecharm.test` |
| Rider, Hamza Ali | `03007654321` |
| Platform admin | `admin@khaanago.test` |

Use the new order number from step 8 everywhere below. Older orders may already be on the board.

## 1. Customer sign-in

1. Open the customer app. The first screen is Login.
2. In **Mobile or email**, enter `03001234567`.
3. In **Password**, enter `password12`.
4. Press **Continue**.

Expected: Home opens. The address line reads **F-11, Islamabad**. The bottom bar shows Home, Orders, Assistant, and Profile. There is no error banner.

## 2. Browse

1. Stay on Home. Find three kitchens: BakeCharm, Lazeez Karahi, and Margalla Grill.
2. Press the **Open now** chip, then press it again to clear it.
3. Press the **BakeCharm** card.

Expected: BakeCharm shows a rating, **40–55 min**, and a capacity chip (**Quiet**, **Busy**, or **Fully booked**) plus the next slot. Margalla Grill is not tappable and reads **Opens at 12:00 pm**. The menu is titled **BakeCharm**. **Chocolate fudge cake** is **Rs 1850**. **Walnut brownie** is grey and reads **Sold out**.

## 3. Customise

1. Tap **Chocolate fudge cake**.
2. Leave the quantity at **1**. Press **Add to cart**.
3. In **Instructions for the kitchen**, type `No nuts`.
4. Press **Save customization**.

Expected: the item screen shows **Rs 1850**, **Fragile · express only**, and **Allergens: Milk, egg, gluten**. The cart reads **1 × Chocolate fudge cake**, **No nuts**, **Food Rs 1850**, and **One kitchen per order: BakeCharm**.

## 4. Pick a slot

1. Press **Choose delivery**.
2. Leave **Express** selected (Rs 180). Pooled stays disabled.
3. Press **Choose a slot**.
4. Tap the first BakeCharm time that is not greyed out. Typical times are **6:30 PM**, **7:00 PM**, **7:30 PM**, and **8:30 PM**. Skip any row you cannot tap.
5. Press **Hold this slot**.

Expected: trying to select **Pooled** does nothing useful, and the row says **Not available for fragile items**. After the hold, the notice reads **Slot held for 5 minutes** and the payment screen opens. If the hold expired, go back, pick the slot again, and hold it again before paying.

## 5. Pay

1. Select **Cash on delivery**.
2. Press **Review order**.
3. Check the summary, then press **Place order**.

Expected: the review reads **1 × Chocolate fudge cake · BakeCharm**, the slot you held, **express**, **Cash on delivery**, **Food Rs 1850**, **Delivery Rs 180**, and **Total Rs 2030**. Place order opens live tracking. The large line is **Ready by** the slot time, with **pm** in lower case. The stepper highlights **Placed**. Expand **Order KG-…** and you see **1 × Chocolate fudge cake** and **Cash on delivery**.

## 6. Vendor receives it

1. Open http://localhost:5173.
2. Sign in as `owner@bakecharm.test` / `password12`.
3. Stay on **Live Orders**.

Expected: within about 3 seconds a card appears in **New** with an orange highlight that fades. The card shows the order number, **Just now**, a **Ref** thumbnail, **1 × Chocolate fudge cake**, **No nuts**, the slot, a **COD** badge, and **Accept**. The sidebar is Live Orders, Menu, Inventory (BOM/MRP), Capacity, Offers, Finance, Staff, and Settings.

## 7. Move it to Preparing

1. On the new card, press **Accept**. You can instead drag the card onto **Preparing**.

Expected: the card leaves **New** and the button becomes **Mark ready**. Within about 3 seconds the customer tracking line is still **Ready by** the slot. **Accepted** has a time, and **Preparing** is the highlighted step.

## 8. Move it to Ready

1. Press **Mark ready**, or drag the card onto **Ready**.

Expected: the card is in **Ready** and the button is **Hand to rider**. The customer headline changes to **Ready now**, and **Ready** is the highlighted step.

Leave the card in **Ready**. Do not press **Hand to rider** yet. That button marks the order handed over without assigning Hamza, and the rider can no longer pick it up.

## 9. Rider alert

1. Open the rider app and sign in as `03007654321` / `password12`. Press **Continue**.
2. Stay on the rider home.

Expected: a ready alert for this order number, with a way to pick it up, without opening the hidden screen list.

## 10. Rider pickup

1. If the home screen shows the order, pick it up from there.
2. If it does not, long-press the screen title until the menu icon appears, open the screen list, and open **Head to pickup**. Press the orange **Update KG-…** button.

Expected: the order moves to **Handed to rider** on the vendor board. There is no second button on that column. The customer headline becomes **On the way**. A rider card shows **Hamza Ali**, **Motorbike**, and **Code** plus a 6-digit code. The stepper highlights **On the way**.

## 11. Deliver

1. On the customer tracking screen, read the 6-digit code on the rider card.
2. On the rider app, open **Delivery code entry** from the screen list if you are not already on a screen with **6-digit delivery code**.
3. Type that code into **6-digit delivery code** and press Enter.

Expected: the customer headline becomes **Delivered**, and **Delivered** is highlighted on the stepper. The orange **Track order** banner disappears. Do not press the orange **Update** button on the rider screen after pickup. That button tries to pick the order up again.

## 12. Invoice

1. On the vendor portal, press **Finance**.

Expected: an invoice row **INV-** plus the order number, status **Pending – COD**, and total **Rs 2,030**. Revenue includes this order. The customer **Orders** tab lists the same order as **Delivered**.

## 13. Admin view

1. Open http://localhost:5174.
2. Sign in as `admin@khaanago.test` / `password12`.
3. In the left list, press **Live dashboard**.

Expected: the first screen after sign-in is **Admin sign-in**, not the dashboard. After you open **Live dashboard**, the live queue includes this order with status **delivered** and vendor **bakecharm**.

## 14. Kitchen "Hand to rider" before the rider

On a second order, repeat steps 1–8, then press **Hand to rider** while the card is in **Ready**, before the rider picks it up.

Expected: the rider can still accept that order, and the customer rider card shows **Hamza Ali**.
