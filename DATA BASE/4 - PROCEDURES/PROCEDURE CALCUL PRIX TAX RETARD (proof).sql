USE [CAR_RENTAL]
GO
/****** Object:  StoredProcedure [dbo].[CALCULATE_LATE_FEE_AND_TAX]    Script Date: 1/11/2017 10:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[CALCULATE_LATE_FEE_AND_TAX]
(@actualReturnDateTime datetime /* Use -meta option BOOKING_DETAILS.ACT_RET_DT_TIME%TYPE */,
@ReturnDateTime datetime /* Use -meta option BOOKING_DETAILS.RET_DT_TIME%TYPE */,
@regNum VARCHAR(7) /* Use -meta option BOOKING_DETAILS.REG_NUM%TYPE */, 
@amount NUMERIC(10,2) /* Use -meta option BOOKING_DETAILS.AMOUNT%TYPE */,
@totalLateFee NUMERIC(10,2) /* le prix total apres l'ajoute de prix de retard BILLING_DETAILS.TOTAL_AMOUNT%TYPE */ OUT,
@totalTax NUMERIC(10,2) /* Use les tax BILLING_DETAILS.TAX_AMOUNT%TYPE */ OUT ) AS
 BEGIN
--local declarations
DECLARE @lateFeePerHour NUMERIC(5,2) /* Use -meta option CAR_CATEGORY.LATE_FEE_PER_HOUR%TYPE */;
DECLARE @hourDifference DECIMAL(10,2);
 
SET NOCOUNT ON;
  SELECT @lateFeePerHour = LATE_FEE_PER_HOUR 
  FROM CAR_CATEG CC INNER JOIN CAR C ON CC.CATEGORY_NAME = C.CAR_CATEGORY_NAME 
  WHERE C.REGISTRATION_NUMBER = @regNum;
  
  IF @actualReturnDateTime > @ReturnDateTime BEGIN
    SET @hourDifference = -1*(SELECT DATEDIFF(hour, @actualReturnDateTime, @ReturnDateTime));
	print 'hours diff   ' + CAST(@hourDifference AS VARCHAR);
    SET @totalLateFee = @hourDifference * @lateFeePerHour;
  END
  ELSE BEGIN
    SET @totalLateFee = 0;
  END 
  SET @totalTax = (@amount + @totalLateFee)*0.0825;
END;
