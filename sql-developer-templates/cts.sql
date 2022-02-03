DECLARE
  schema_name VARCHAR2(28);
  c NUMBER;
BEGIN
  schema_name := '[(schema)]';
  SELECT COUNT(*) INTO c FROM all_users WHERE username = schema_name;
  IF (c > 0) THEN EXECUTE IMMEDIATE 'DROP USER "' || schema_name || '" CASCADE'; END IF;
  EXECUTE IMMEDIATE 'CREATE USER "' || schema_name || '" IDENTIFIED BY ' || DBMS_RANDOM.string('a', 20);
  EXECUTE IMMEDIATE 'GRANT UNLIMITED TABLESPACE TO "' || schema_name || '"';
END;
/
