
--declare @actualReturnDateTime datetime ; /* Use -meta option BOOKING_DETAILS.ACT_RET_DT_TIME%TYPE */
--declare @ReturnDateTime datetime ;/* Use -meta option BOOKING_DETAILS.RET_DT_TIME%TYPE */
--declare @regNum VARCHAR(7) ;/* Use -meta option BOOKING_DETAILS.REG_NUM%TYPE */
--declare @amount NUMERIC(10,2); /* Use -meta option BOOKING_DETAILS.AMOUNT%TYPE */
--declare @totalLateFee NUMERIC(10,2); /* le prix total apres l'ajoute de prix de retard BILLING_DETAILS.TOTAL_AMOUNT%TYPE */ 
--declare @totalTax  NUMERIC(10,2); /* Use les tax BILLING_DETAILS.TAX_AMOUNT%TYPE */ 

--set @actualReturnDateTime = (select GETDATE());
--set @ReturnDateTime = (select RET_DT_TIME from BOOKING_DETAILS where BOOKING_ID = 'B1005')
--set @regNum = 'POI7281';
--set @amount = 100.00;


--exec CALCULATE_LATE_FEE_AND_TAX @actualReturnDateTime,@ReturnDateTime,@regNum,@amount,@totalLateFee output,@totalTax output
--print 'TOTAL fee  ' + CAST(@totalLateFee AS VARCHAR)
--print 'Tax fee  ' + CAST(@totalTax AS VARCHAR)


declare @dlNum VARCHAR(8) /* Numero de client */
declare @amount NUMERIC(10,2) /* PRIX TOTAL */
declare @discountCode CHAR(4) /* le CODE DU PROMO dans la table DISCOUNT_DETAILES */
declare @discountAmt NUMERIC(4,2) /* le taux de remise dans la table  BILLING_DETAILS */ 

set @dlNum = 'F1234554';
set @amount = 100.00;
set @discountCode = 'D109';

exec CALCULATE_DISCOUNT_AMOUNT @dlNum,@amount,@discountCode,@discountAmt output
print 'disc amount  ' + CAST(@discountAmt AS VARCHAR)


