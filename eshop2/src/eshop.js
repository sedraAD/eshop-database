/**
 * A module exporting functions to access the bank database.
 */
"use strict";

module.exports = {
    showLog,
    showAllProducts,
    showAllShelves,
    showInventory,
    showInventoryFiltered,
    addInventory,
    removeInventory,
    showAllOrders,
    searchOrders,
    showPicklist,
    shipOrder
};

const mysql  = require("promise-mysql");
const config = require("../config/db/eshop.json");

require("console.table");

let db;

(async function() {
    db = await mysql.createConnection(config);

    process.on("exit", () => {
        db.end();
    });
})();

async function showLog(limit) {
    try {
        const rows = await db.query("CALL get_log(?)", [limit]);

        console.table(rows[0]);
    } catch (err) {
        console.error("Fel vid hämtning av loggar:", err.message);
    }
}

async function showAllProducts() {
    try {
        const rows = await db.query("CALL get_all_products()");

        console.table(rows[0]);
    } catch (err) {
        console.error("Fel vid hämtning av produkter:", err.message);
    }
}

async function showAllShelves() {
    try {
        const rows = await db.query("CALL get_all_shelves()");

        console.table(rows[0]);
    } catch (err) {
        console.error("Fel vid hämtning av hyllor:", err.message);
    }
}

async function showInventory() {
    try {
        const rows = await db.query("CALL get_inventory()");

        console.table(rows[0]);
    } catch (err) {
        console.error("Fel vid hämtning av inventering:", err.message);
    }
}

async function showInventoryFiltered(filterStr) {
    try {
        const rows = await db.query("CALL get_inventory_filtered(?)", [filterStr]);

        console.table(rows[0]);
    } catch (err) {
        console.error("Fel vid hämtning av filtrerad inventering:", err.message);
    }
}

async function addInventory(prodId, shelfId, amount) {
    try {
        await db.query("CALL add_inventory(?, ?, ?)", [prodId, shelfId, amount]);
        console.log(`Lagret för produkt ${prodId} 
            på hylla ${shelfId} har uppdaterats med ${amount} enheter.`);
    } catch (err) {
        console.error("Fel vid uppdatering av inventering:", err.message);
    }
}

async function removeInventory(prodId, shelfId, amount) {
    try {
        const result = await db.query("CALL remove_inventory(?, ?, ?)", [prodId, shelfId, amount]);

        if (result && result[0] && result[0].length > 0) {
            console.log(result[0][0].message);
        }
    } catch (err) {
        console.error("Fel vid  av inventering:", err.message);
    }
}

async function showAllOrders() {
    try {
        const rows = await db.query("CALL get_all_orders()");

        console.table(rows[0]);
    } catch (err) {
        console.error("Fel vid hämtning av ordrar:", err.message);
    }
}

async function searchOrders(searchTerm) {
    try {
        const allOrders = await db.query("CALL get_all_orders()");
        const filtered = allOrders[0].filter(order =>
            order.ordernummer.toString().includes(searchTerm) ||
            order.kund_id.toString().includes(searchTerm)
        );

        console.table(filtered);
    } catch (err) {
        console.error("Fel vid sökning av ordrar", err.message);
    }
}

async function showPicklist(orderId) {
    try {
        const [rows] = await db.query("CALL get_picklist(?)", [orderId]);

        console.log(`Plocklista för order #${orderId}`);
        console.log("------------------------------------------");

        for (let row of rows) {
            if (row.lager_id === null) {
                console.log(`FINNS INTE! ${row.antal} x ${row.produkt_namn} finns EJ i lager!`);
            } else {
                console.log(`FINNS! ${row.antal} x 
                    ${row.produkt_namn} från hylla "${row.hylla_namn}" (id: ${row.hylla_id})`);
            }
        }
    } catch (err) {
        console.error("Fel vid hämtning av plocklista:", err.message);
    }
}

async function shipOrder(orderId) {
    try {
        await db.query("CALL ship_order(?)", [orderId]);
        console.log(`Order #${orderId} har markerats som skickad.`);
    } catch (err) {
        console.error("Fel vid uppdatering av orderstatus:", err.message);
    }
}
