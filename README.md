# E-shop Database Project

This project is a e-shop system developed as part of a database course.  
It focuses on SQL, relational database design, backend integration and includes both a terminal-based interface and a web-based interface.

## Overview

The project consists of:
- A relational database for an e-shop
- SQL scripts for setup, data insertion, reset, and backup
- A backend that connects the database to the application
- A terminal-based menu for interacting with the system
- A web interface for browsing and managing data

## Features

- Product, category, customer, order, and inventory management
- Well-structured SQL schema with relations and constraints
- CRUD operations via backend logic
- Terminal-based CLI for administrative tasks
- Web-based interface built with server-side rendering
- Clear separation between database, backend, and views

## Technologies Used

- SQL
- Relational database design
- JavaScript (Node.js)
- Express
- EJS templates

## Project Structure

- `sql/eshop/` – SQL scripts (setup, insert, reset, backup)
- `src/` – Backend logic
- `route/` – Application routing
- `middleware/` – Middleware logic
- `views/` – Web interface templates
- `cli.js` – Terminal-based menu interface
- `index.js` – Application entry point

---

## How to Run the Project

### 1. Set up the database
1. Create a database in your SQL environment
2. Run the reset script:
   ```sql
   source sql/eshop/reset.sql;
   ```
3. Install dependencies
   ```bash
   npm install
   ```
4. Start the application
   ```bash
   node index.js
   ```
5. open the browser the program is running on.

- If you want to start the terminal-based interface:
  ```bash
  node cli.js
  ```
---

# Author 

Project developed by sedra Abou Daher - Databasteknologier för webben - DV1606
