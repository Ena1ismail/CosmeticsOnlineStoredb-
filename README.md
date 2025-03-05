# CosmeticsOnlineStoredb-
This Cosmetic Store Database is a structured SQL Server database designed to efficiently manage a cosmetic store’s operations, including product inventory, order processing, customer interactions, and sales tracking. The database ensures data integrity, relationships, and constraints for seamless management of store transactions.

The database consists of multiple normalized tables to handle various aspects of the store:
🔹 Core Tables
User – Stores customer and admin details, including authentication information.
Item – Manages all cosmetic products, including pricing, categories, and brands.
Order – Contains customer orders with timestamps and statuses.
OrderItem – Stores detailed records of items purchased within each order.
Wishlist – Allows customers to save products they wish to purchase later.
ItemRequests – Tracks new product requests submitted by customers.
Ingredients – Stores individual cosmetic ingredients used in different products.
ItemIngredient – Links products (Item) to their corresponding ingredients (Ingredients) and defines required quantities.
🔹 Lookup Tables
LookupTypes – Defines lookup categories such as order statuses, brands, and product categories.
LookupItems – Stores the actual values for each lookup type (e.g., "Shipped" for order status, "Skincare" for category).
