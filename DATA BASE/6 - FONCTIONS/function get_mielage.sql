CREATE VIEW rndView
AS
SELECT RAND() rndResult
GO


create function get_mileage()
returns float
as
begin
declare @mileage float /* Use -meta option CAR.MILEAGE%type */;
declare @rand float
set @rand =  (select rndResult  FROM rndView);
 
set @mileage =  floor((@rand*10 - 5 + 1))+ 5;

/*dbms_random.value(100,10000);*/
return @mileage;
end;
GO