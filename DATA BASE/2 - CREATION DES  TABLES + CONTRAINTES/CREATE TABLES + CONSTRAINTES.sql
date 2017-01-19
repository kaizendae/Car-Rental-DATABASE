CREATE TABLE Client
( Client_ID CHAR(8) NOT NULL,
  FNAME VARCHAR(25) NOT NULL,
  MNAME VARCHAR(15),
  LNAME VARCHAR(25) NOT NULL,
  PHONE_NUMBER NUMERIC(10) NOT NULL,
  EMAIL_ID VARCHAR(30) NOT NULL,
  STREET VARCHAR(30) NOT NULL,
  CITY VARCHAR(20) NOT NULL,
  STATE_NAME VARCHAR(20) NOT NULL,
  ZIPCODE NUMERIC(5) NOT NULL,
  MEMBERSHIP_TYPE CHAR(1) DEFAULT 'N' NOT NULL,
  MEMBERSHIP_ID CHAR(5),

  CONSTRAINT CUSTOMERPK
  PRIMARY KEY (Client_ID)
);

CREATE TABLE CAR_CATEG
( CATEGORY_NAME VARCHAR(25) NOT NULL,
  NO_OF_LUGGAGE INTEGER NOT NULL,
  NO_OF_PERSON INTEGER NOT NULL,
  COST_PER_DAY NUMERIC(5,2) NOT NULL,
  LATE_FEE_PER_HOUR NUMERIC(5,2) NOT NULL,

  CONSTRAINT CARCATEGORYPK
  PRIMARY KEY (CATEGORY_NAME)
);

CREATE TABLE LOCATION_DETAILS
( LOCATION_ID CHAR(4) NOT NULL,
  LOCATION_NAME VARCHAR(50) NOT NULL,
  STREET VARCHAR(30) NOT NULL,
  CITY VARCHAR(20) NOT NULL,
  STATE_NAME VARCHAR(20) NOT NULL,
  ZIPCODE NUMERIC(5) NOT NULL,

  CONSTRAINT LOCATIONPK
  PRIMARY KEY (LOCATION_ID)
);

CREATE TABLE CAR
( REGISTRATION_NUMBER CHAR(7) NOT NULL,
  MODEL_NAME VARCHAR(25) NOT NULL,
  MAKE VARCHAR(25) NOT NULL,
  MODEL_YEAR NUMERIC(4) NOT NULL,
  MILEAGE INTEGER NOT NULL,
  CAR_CATEGORY_NAME VARCHAR(25) NOT NULL,
  LOC_ID CHAR(4) NOT NULL,
  AVAILABILITY_FLAG CHAR(1) NOT NULL,

  CONSTRAINT CARPK
  PRIMARY KEY (REGISTRATION_NUMBER),

  CONSTRAINT CARFK1
  FOREIGN KEY (CAR_CATEGORY_NAME) REFERENCES CAR_CATEG(CATEGORY_NAME),

  CONSTRAINT CARFK2
  FOREIGN KEY (LOC_ID) REFERENCES LOCATION_DETAILS(LOCATION_ID)
);

CREATE TABLE DISCOUNT_DETAILS
( DISCOUNT_CODE CHAR(4) NOT NULL,
  DISCOUNT_NAME VARCHAR(25) NOT NULL,
  EXPIRE_DATE DATE NOT NULL,
  DISCOUNT_PERCENTAGE NUMERIC(4,2)  NOT NULL,

  CONSTRAINT DISCOUNTPK
  PRIMARY KEY (DISCOUNT_CODE),

  CONSTRAINT DISCOUNTSK
  UNIQUE (DISCOUNT_NAME)
);

CREATE TABLE RENTAL_CAR_INSURANCE
( INSURANCE_CODE CHAR(4) NOT NULL,
  INSURANCE_NAME VARCHAR(50) NOT NULL,
  COVERAGE_TYPE VARCHAR(200) NOT NULL,
  COST_PER_DAY NUMERIC(4,2) NOT NULL,

  CONSTRAINT INSURANCEPK
  PRIMARY KEY (INSURANCE_CODE),

  CONSTRAINT INSURANCESK
  UNIQUE (INSURANCE_NAME)
);

CREATE TABLE BOOKING_DETAILS
( BOOKING_ID CHAR(5) NOT NULL,
  FROM_DT_TIME DATETIME NOT NULL,
  RET_DT_TIME DATETIME NOT NULL,
  AMOUNT NUMERIC(10,2) NOT NULL,
  BOOKING_STATUS CHAR(1) NOT NULL,
  PICKUP_LOC  CHAR(4) NOT NULL,
  DROP_LOC CHAR(4) NOT NULL,
  REG_NUM CHAR(7) NOT NULL,
  DL_NUM CHAR(8) NOT NULL,
  INS_CODE CHAR(4),
  ACT_RET_DT_TIME DATETIME,
  DISCOUNT_CODE CHAR(4),

  CONSTRAINT BOOKINGPK
  PRIMARY KEY (BOOKING_ID),

  CONSTRAINT BOOKINGFK1
  FOREIGN KEY (PICKUP_LOC) REFERENCES LOCATION_DETAILS(LOCATION_ID),

  CONSTRAINT BOOKINGFK2
  FOREIGN KEY (DROP_LOC) REFERENCES LOCATION_DETAILS(LOCATION_ID),

  CONSTRAINT BOOKINGFK3
  FOREIGN KEY (REG_NUM) REFERENCES CAR(REGISTRATION_NUMBER),

  CONSTRAINT BOOKINGFK4
  FOREIGN KEY (DL_NUM) REFERENCES Client(Client_ID),

  CONSTRAINT BOOKINGFK5
  FOREIGN KEY (INS_CODE) REFERENCES RENTAL_CAR_INSURANCE(INSURANCE_CODE),

  CONSTRAINT BOOKINGFK6
  FOREIGN KEY (DISCOUNT_CODE) REFERENCES DISCOUNT_DETAILS(DISCOUNT_CODE)
);

CREATE TABLE BILLING_DETAILS
( BILL_ID CHAR(6) NOT NULL,
  BILL_DATE DATE NOT NULL,
  BILL_STATUS CHAR(1) NOT NULL,
  DISCOUNT_AMOUNT NUMERIC(10,2) NOT NULL,
  TOTAL_AMOUNT NUMERIC(10,2) NOT NULL,
  TAX_AMOUNT NUMERIC(10,2) NOT NULL,
  BOOKING_ID CHAR(5) NOT NULL,
  TOTAL_LATE_FEE NUMERIC(10,2) NOT NULL,

  CONSTRAINT BILLINGPK
  PRIMARY KEY (BILL_ID),

  CONSTRAINT BILLINGFK1
  FOREIGN KEY (BOOKING_ID) REFERENCES BOOKING_DETAILS(BOOKING_ID)
);


/*
DROP TABLE BILLING_DETAILS;
DROP TABLE BOOKING_DETAILS;
DROP TABLE RENTAL_CAR_INSURANCE;
DROP TABLE DISCOUNT_DETAILS;
DROP TABLE CAR;
DROP TABLE LOCATION_DETAILS;
DROP TABLE CAR_CATEG;
DROP TABLE Client;
*/
