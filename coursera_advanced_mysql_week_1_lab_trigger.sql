DELIMITER //

DROP TRIGGER if exists ProductSellPriceInsertCheck//


CREATE TRIGGER ProductSellPriceInsertCheck
AFTER INSERT on Products FOR EACH ROW
BEGIN
 if NEW.SellPrice <= NEW.BuyPrice THEN
  INSERT into Notifications VALUES(NULL,concat("ProductID",NEW.ProductID, "was updated with a SellPrice of",
  NEW.SellPrice,"which is the same or less than the BuyPrice"),CURRENT_TIME());

 END IF;

END //


DROP TRIGGER if exists ProductSellPriceUpdateCheck//


CREATE TRIGGER ProductSellPriceUpdateCheck
AFTER UPDATE on Products FOR EACH ROW
BEGIN
 if NEW.SellPrice <= NEW.BuyPrice THEN
  INSERT into Notifications VALUES(NULL,concat("ProductID",NEW.ProductID, "was updated with a SellPrice of",
  NEW.SellPrice,"which is the same or less than the BuyPrice"),CURRENT_TIME());

 END IF;

END //


DROP TRIGGER if exists NotifyProductDelete//


CREATE TRIGGER NotifyProductDelete
AFTER DELETE on Products FOR EACH ROW
BEGIN
  INSERT into Notifications VALUES(NULL,concat("The product with a ProductID",OLD.ProductID,"was deleted"),CURRENT_TIME());
END //


DELIMITER ;


INSERT into Products VALUES("P7", "Product 7", 40, 40, 100);

select * from Products;

select * from Notifications;

DELETE from Products where ProductID = "P7";


INSERT into Products VALUES("P8", "Product 8", 40, 50, 100);

select * from Products;

select * from Notifications;


UPDATE Products set SellPrice = 40 where ProductID = "P8";

select * from Products;

select * from Notifications;

DELETE from Products where ProductID = "P8";
