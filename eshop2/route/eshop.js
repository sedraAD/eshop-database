/**
 * Route for eshop.
 */
"use strict";

const express = require("express");
const router  = express.Router();
const mysql = require("promise-mysql");
const dbConfig = require("../config/db/eshop.json");


router.get("/index", (req, res) => {
    let data = {
        title: "Welcome | Eshop"
    };

    res.render("index", data);
});


router.get("/about", (req, res) => {
    let data = {
        title: "About | Eshop"
    };

    res.render("about", data);
});

router.get("/category", async (req, res) => {
    let data = {
        title: "Categories | Eshop"
    };

    const db = await mysql.createConnection(dbConfig);
    let rows = await db.query("CALL get_all_categories()");

    await db.end();

    data.categories = rows[0];

    res.render("category", data);
});

router.get("/product", async (req, res) => {
    let data = {
        title: "Products | Eshop"
    };

    const db = await mysql.createConnection(dbConfig);

    let rows = await db.query("CALL get_all_products()");

    await db.end();

    data.products = rows[0];

    res.render("product", data);
});

router.get("/product/create", async (req, res) => {
    const db = await mysql.createConnection(dbConfig);

    let rows = await db.query("CALL get_all_categories()");

    await db.end();

    res.render("product_crud/create", {
        title: "Add product | Eshop",
        categories: rows[0]
    });
});

router.post("/product/create", async (req, res) => {
    const { namn, beskrivning, pris } = req.body;

    const db = await mysql.createConnection(dbConfig);

    await db.query("CALL add_product(?, ?, ?)", [namn, beskrivning, pris]);
    await db.end();

    res.redirect("/eshop/product");
});

router.get("/product/edit/:id", async (req, res) => {
    const produktId = req.params.id;
    const db = await mysql.createConnection(dbConfig);

    const produktRows = await db.query("CALL get_product(?)", [produktId]);

    await db.end();

    res.render("product_crud/edit", {
        title: "Edit product | Eshop",
        produkt: produktRows[0][0],
    });
});

router.post("/product/edit/:id", async (req, res) => {
    const produktId = req.params.id;
    const { namn, beskrivning, pris } = req.body;

    const db = await mysql.createConnection(dbConfig);

    await db.query("CALL update_product(?, ?, ?, ?)", [produktId, namn, beskrivning, pris]);
    await db.end();

    res.redirect("/eshop/product");
});

router.get("/product/delete/:id", async (req, res) => {
    const produktId = req.params.id;

    const db = await mysql.createConnection(dbConfig);

    await db.query("CALL delete_product(?)", [produktId]);
    await db.end();

    res.redirect("/eshop/product");
});

router.get("/customer", async (req, res) => {
    let data = {
        title: "Customers | Eshop"
    };

    const db = await mysql.createConnection(dbConfig);
    let rows = await db.query("CALL get_all_customers()");

    await db.end();

    data.customers = rows[0];

    res.render("customer", data);
});

router.get("/order/new/:customerId", async (req, res) => {
    const customerId = req.params.customerId;
    const db = await mysql.createConnection(dbConfig);

    const orderResult = await db.query("CALL create_order(?)", [customerId]);
    const orderId = orderResult[0][0].order_id;

    await db.end();

    res.redirect(`/eshop/order/create/${orderId}`);
});

router.get("/order/create/:orderId", async (req, res) => {
    const orderId = req.params.orderId;
    const db = await mysql.createConnection(dbConfig);

    const productsResult = await db.query("CALL get_all_products()");
    const orderRowresult = await db.query("CALL get_order_rows(?)", [orderId]);

    await db.end();

    res.render("order/create", {
        title: `Create Order #${orderId}`,
        orderId,
        products: productsResult[0],
        orderRows: orderRowresult[0]
    });
});

router.post("/order/add-product", async (req, res) => {
    const { order_id: orderId, produkt_id: produktId, antal } = req.body;

    const db = await mysql.createConnection(dbConfig);

    try {
        const result = await db.query(
            "CALL check_stock(?, @stock); SELECT @stock AS saldo;", [produktId]);
        const saldo = result[1][0].saldo;

        if (saldo < antal) {
            const productsResult = await db.query("CALL get_all_products()");
            const orderRowResult = await db.query("CALL get_order_rows(?)", [orderId]);

            res.render("order/create", {
                title: `Create Order #${orderId}`,
                order_id: orderId,
                products: productsResult[0],
                orderRows: orderRowResult[0],
                error: "❌ Produkten finns inte i tillräcklig mängd i lager."
            });
            return;
        }
        await db.query("CALL add_order_row(?, ?, ?)", [orderId, produktId, antal]);
        res.redirect(`/eshop/order/create/${orderId}`);
    } catch (err) {
        console.error(err);
        res.send("❌ Ett fel uppstod.");
    } finally {
        await db.end();
    }
});

router.post("/order/confirm", async (req, res) => {
    const { order_id: orderId } = req.body;

    const db = await mysql.createConnection(dbConfig);

    await db.query("CALL confirm_order(?)", [orderId]);
    await db.end();

    res.redirect(`/eshop/order`);
});

router.get("/order", async (req, res) => {
    const db = await mysql.createConnection(dbConfig);

    const result = await db.query("CALL get_all_orders()");
    const orders = result[0];

    await db.end();

    res.render("order/index", {
        title: "Orders | Eshop",
        orders
    });
});

router.get("/order/:orderId", async (req, res) => {
    const orderId = req.params.orderId;

    const db = await mysql.createConnection(dbConfig);

    const orderRows = await db.query("CALL get_order_rows(?)", [orderId]);

    await db.end();

    res.render("order/view", {
        title: `Order #${orderId}`,
        orderId: orderId,
        orderRows: orderRows[0]
    });
});

module.exports = router;
