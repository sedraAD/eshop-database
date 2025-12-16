/**
 * This module provides a command-line interface for interactions with bank.
 *
 * @author Sedra
 */
"use strict";

const readline =require("readline");
const eshop = require("./eshop.js");

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
    prompt: "Kommando: "
});


function showMenu() {
    console.log(`
        Välj ett kommando: 
        1. menu :                  Visar meny
        2. exit :                  Avsluta programmet
        3. about :                 Visa namn på de som jobbat
        4. log <number> :          Visa de <number> senaste logghändelserna
        5. product:                Visa alla produkter
        6. shelf:                  Visa alla lagerhyllor
        7. inv:                    Visa lageröversikt
        8. inv <str>               Filtrera lageröversikt
        9. invadd <id> <hylla> <antal>:  Lägg till produkter i lager
        10. invdel <id> <hylla> <antal>: Ta bort produkter från lager
        11. order <search>         Visa alla ordrar eller sök 
        12. picklist <orderid>     Visa plocklista för en vald order
        13. ship <orderid>         Skicka beställning
        `);
}


function exitProgram() {
    console.info("Exiting program. ");
    process.exit(0);
}


async function handleInput(input) {
    let args = input.trim().split(" ");
    let command = args.shift();

    switch (command) {
        case "exit":
            exitProgram();
            break;
        case "menu":
            showMenu();
            break;
        case "about":
            console.log("Eshop by: Sedra Abou Daher");
            break;
        case "log": {
            let antal = parseInt(args[0]);

            if (isNaN(antal)) {
                console.log("Användning: log <antal>");
            } else {
                await eshop.showLog(antal);
            }
            break;
        }
        case "product":
            await eshop.showAllProducts();
            break;
        case "shelf":
            await eshop.showAllShelves();
            break;
        case "inv":
            if (args.length > 0) {
                await eshop.showInventoryFiltered(args[0]);
            } else {
                await eshop.showInventory();
            }
            break;
        case "invadd":
            if (args.length === 3) {
                const productID = parseInt(args[0]);
                const shelfID = parseInt(args[1]);
                const quantity = parseInt(args[2]);

                await eshop.addInventory(productID, shelfID, quantity);
            } else {
                console.log(
                    "Feaktigt antal argument. Använd kommandot som: invadd <id> <hylla> <antal>");
            }
            break;
        case "invdel":
            if (args.length === 3) {
                const productID = parseInt(args[0]);
                const shelfID = parseInt(args[1]);
                const quantity = parseInt(args[2]);

                await eshop.removeInventory(productID, shelfID, quantity);
            } else {
                console.log(
                    "Feaktigt antal argument. Använd kommandot som:invdel <id> <hylla> <antal>");
            }
            break;
        case "order":
            if (args.length === 0) {
                await eshop.showAllOrders();
            } else {
                await eshop.searchOrders(args[0]);
            }
            break;
        case "picklist":
            if (args.length !== 1) {
                console.log("Användning: picklist <orderid>");
            } else {
                await eshop.showPicklist(args[0]);
            }
            break;
        case "ship":
            if (args.length === 1) {
                const orderId = parseInt(args[0]);

                if (!isNaN(orderId)) {
                    await eshop.shipOrder(orderId);
                } else {
                    console.log("Användning: ship <orderid>");
                }
            } else {
                console.log("Användning: ship <orderid>");
            }
            break;
        default:
            console.log("Okänt kommando, skriv 'menu' för hjälp.");
    }
    rl.prompt();
}


function mainLoop() {
    showMenu();
    rl.prompt();

    rl.on("line", async (input) => {
        await handleInput(input);
    });

    rl.on("close", () => {
        console.log("programmet har stängts.");
        process.exit(0);
    });
}

module.exports = { mainLoop };
