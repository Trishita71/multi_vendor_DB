# Multi-Vendor E-Commerce Database (SQL)

A relational database design and implementation for a multi-vendor e-commerce platform — covering ERD design, table creation, sample data and a range of SQL queries from basic joins to advanced aggregations.

## 📌 Overview

This project models a marketplace where multiple vendors sell products under subscription plans, customers place orders across vendors and payments are tracked per order. It includes the full database schema, sample data, and analytical queries.

## 🗂️ Entities

- **subscriptionPlans** — Plans vendors subscribe to (Basic, Premium, Enterprise)
- **Vendor** — Business details, linked to a subscription plan
- **Category** — Product categories
- **Product** — Vendor products, linked to categories (many-to-many via `ProductCategory`)
- **Customer** — Customer details
- **Orders** — Customer orders
- **OrderItem** — Line items per order
- **Payment** — Payment details per order

## 🖼️ ERD

See `ERD.png` in this repository for the full entity-relationship diagram.

## 🛠️ Tech Stack

- MySQL

## 📁 Repository Structure

```
.
├── multi_vendor_database.sql   # DDL, sample data and all queries
├── ERD.png                     # Entity-relationship diagram
└── README.md
```

## 🧮 What's Included

| Part | Content |
|------|---------|
| A | ERD & Database Design |
| B | SQL DDL — table creation with constraints, foreign keys and sample data inserts |
| C | SQL DML — insert, update, delete operations |
| D | SQL DQL — vendor/product/order/payment lookup queries |
| E | Advanced SQL — sales aggregation, customer analytics, multi-vendor purchase detection |

## ▶️ How to Run

1. Clone the repository
   ```bash
   git clone https://github.com/<your-username>/<repo-name>.git
   cd <repo-name>
   ```
2. Open MySQL and run the script
   ```bash
   mysql -u <username> -p < multi_vendor_database.sql
   ```

## 👤 Author

Trishita Paul — Department of CSE, International Islamic University Chittagong (IIUC)

## 📄 License

This project is for academic purposes.
