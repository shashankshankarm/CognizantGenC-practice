-- Create ACCOUNTS table
CREATE TABLE ACCOUNTS (
  AccountID   NUMBER PRIMARY KEY,
  AccountType VARCHAR2(20),
  Balance     NUMBER
);

-- Create EMPLOYEES table
CREATE TABLE EMPLOYEES (
  EmployeeID    NUMBER PRIMARY KEY,
  DepartmentID  NUMBER,
  Salary        NUMBER
);

-- Insert sample data
INSERT INTO ACCOUNTS (AccountID, AccountType, Balance) VALUES (1001, 'SAVINGS', 1000);
INSERT INTO ACCOUNTS (AccountID, AccountType, Balance) VALUES (1002, 'SAVINGS', 2000);
INSERT INTO ACCOUNTS (AccountID, AccountType, Balance) VALUES (1003, 'CURRENT', 1500);

INSERT INTO EMPLOYEES (EmployeeID, DepartmentID, Salary) VALUES (1, 101, 5000);
INSERT INTO EMPLOYEES (EmployeeID, DepartmentID, Salary) VALUES (2, 101, 6000);
INSERT INTO EMPLOYEES (EmployeeID, DepartmentID, Salary) VALUES (3, 102, 7000);

COMMIT;

-- Turn on output
SET SERVEROUTPUT ON;

-- Procedure 1: Add Monthly Interest to Savings Accounts
CREATE OR REPLACE PROCEDURE ApplyInterestToSavings IS
BEGIN
  UPDATE ACCOUNTS
  SET Balance = Balance * 1.01
  WHERE AccountType = 'SAVINGS';

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Interest credited to savings account holders.');
END;
/

-- Procedure 2: Grant Bonus to a Department’s Employees
CREATE OR REPLACE PROCEDURE GrantDepartmentBonus(
  p_dept_id NUMBER,
  p_bonus_percent NUMBER
) IS
BEGIN
  UPDATE EMPLOYEES
  SET Salary = Salary + (Salary * (p_bonus_percent / 100))
  WHERE DepartmentID = p_dept_id;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Bonus of ' || p_bonus_percent || '% added to Department ' || p_dept_id || ' employees.');
END;
/

-- Procedure 3: Transfer Amount Between Accounts
CREATE OR REPLACE PROCEDURE PerformFundTransfer(
  p_from_account NUMBER,
  p_to_account   NUMBER,
  p_amount       NUMBER
) IS
  v_current_balance NUMBER;
BEGIN
  SELECT Balance
  INTO v_current_balance
  FROM ACCOUNTS
  WHERE AccountID = p_from_account
  FOR UPDATE;

  IF v_current_balance < p_amount THEN
    RAISE_APPLICATION_ERROR(-20001, 'Not enough balance to complete the transaction.');
  END IF;

  UPDATE ACCOUNTS
  SET Balance = Balance - p_amount
  WHERE AccountID = p_from_account;

  UPDATE ACCOUNTS
  SET Balance = Balance + p_amount
  WHERE AccountID = p_to_account;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Successfully transferred $' || p_amount || ' from Account ' || p_from_account || ' to Account ' || p_to_account || '.');
END;
/

-- Confirm output is enabled
SET SERVEROUTPUT ON;

-- Call Procedure 1: Apply Interest
EXEC ApplyInterestToSavings;

-- Call Procedure 2: Grant Bonus
EXEC GrantDepartmentBonus(101, 10);

-- Call Procedure 3: Transfer Funds
EXEC PerformFundTransfer(1001, 1002, 500);
