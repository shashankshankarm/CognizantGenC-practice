-- Create the CUSTOMERS table
CREATE TABLE CUSTOMERS (
  CustomerID       NUMBER PRIMARY KEY,
  CustomerName     VARCHAR2(100),
  Age              NUMBER,
  Balance          NUMBER,
  LoanInterestRate NUMBER,
  IsVIP            CHAR(1)
);

-- Create the LOANS table
CREATE TABLE LOANS (
  LoanID     NUMBER PRIMARY KEY,
  CustomerID NUMBER,
  DueDate    DATE,
  CONSTRAINT fk_customer FOREIGN KEY (CustomerID) REFERENCES CUSTOMERS(CustomerID)
);

-- Insert sample records into CUSTOMERS
INSERT INTO CUSTOMERS (CustomerID, CustomerName, Age, Balance, LoanInterestRate, IsVIP)
VALUES (1, 'Alice', 65, 12000, 8.5, 'N');

INSERT INTO CUSTOMERS (CustomerID, CustomerName, Age, Balance, LoanInterestRate, IsVIP)
VALUES (2, 'Bob', 45, 9000, 9.0, 'N');

INSERT INTO CUSTOMERS (CustomerID, CustomerName, Age, Balance, LoanInterestRate, IsVIP)
VALUES (3, 'Carol', 70, 11000, 7.5, 'N');

-- Insert sample records into LOANS
INSERT INTO LOANS (LoanID, CustomerID, DueDate)
VALUES (101, 1, SYSDATE + 10);

INSERT INTO LOANS (LoanID, CustomerID, DueDate)
VALUES (102, 2, SYSDATE + 40);

INSERT INTO LOANS (LoanID, CustomerID, DueDate)
VALUES (103, 3, SYSDATE + 5);

COMMIT;

-- Reduce loan interest rate by 1 for customers older than 60
BEGIN
  FOR rec IN (SELECT CustomerID, Age FROM CUSTOMERS) LOOP
    IF rec.Age > 60 THEN
      UPDATE CUSTOMERS
      SET LoanInterestRate = LoanInterestRate - 1
      WHERE CustomerID = rec.CustomerID;
    END IF;
  END LOOP;
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Applied interest discount to senior customers.');
END;
/

-- Update VIP status based on account balance
BEGIN
  FOR client IN (SELECT CustomerID, Balance FROM CUSTOMERS) LOOP
    IF client.Balance > 10000 THEN
      UPDATE CUSTOMERS
      SET IsVIP = 'Y'
      WHERE CustomerID = client.CustomerID;
    END IF;
  END LOOP;
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Updated VIP status for eligible customers.');
END;
/

-- Display reminders for loans due within 30 days
DECLARE
  v_cust_name VARCHAR2(100);
BEGIN
  FOR loan_info IN (
    SELECT LoanID, CustomerID, DueDate
    FROM LOANS
    WHERE DueDate <= SYSDATE + 30
  ) LOOP
    BEGIN
      SELECT CustomerName INTO v_cust_name
      FROM CUSTOMERS
      WHERE CustomerID = loan_info.CustomerID;

      DBMS_OUTPUT.PUT_LINE('Reminder: Loan ' || loan_info.LoanID ||
                           ' for customer ' || v_cust_name ||
                           ' is due on ' || TO_CHAR(loan_info.DueDate, 'DD-MON-YYYY'));
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No customer found for Loan ID ' || loan_info.LoanID);
    END;
  END LOOP;
END;
/
