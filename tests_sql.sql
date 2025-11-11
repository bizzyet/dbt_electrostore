--insert bad row
  INSERT INTO [little-debby].[archive_electrostore].[sales] (
      sale_id,
      customer_id,
      product_id,
      store_id,
      sale_date,
      quantity,
      unit_price,
      discount_percent,
      total_amount,
      _dlt_load_id,
      _dlt_id
  )
  SELECT TOP 1
      999999 AS sale_id,                    -- Random non-existent sale_id
      88888 AS customer_id,                 -- Non-existent customer (will ERROR)
      77777 AS product_id,                  -- Non-existent product (will WARN)
      66666 AS store_id,                    -- Non-existent store (will ERROR)
      sale_date,
      quantity,
      unit_price,
      discount_percent,
      total_amount,
      'test_load' AS _dlt_load_id,
      'test_id_sales' AS _dlt_id
  FROM [little-debby].[archive_electrostore].[sales];


--check 
  SELECT * FROM [little-debby].[archive_electrostore].[sales] WHERE sale_id = 999999;

--clean up
  DELETE FROM [little-debby].[archive_electrostore].[sales] WHERE sale_id = 999999;


--insert bad product row with invalid status
  INSERT INTO [little-debby].[archive_electrostore].[products] (
      product_id,
      name,
      sku,
      category,
      subcategory,
      brand,
      unit_price,
      cost,
      status,
      launch_date,
      _dlt_load_id,
      _dlt_id
  )
  SELECT TOP 1
      999999 AS product_id,               -- Random non-existent product_id
      'Test Product' AS name,
      'TEST-SKU-999' AS sku,
      category,
      subcategory,
      brand,
      unit_price,
      cost,
      'Pending' AS status,                -- Invalid status (will FAIL accepted_values test)
      launch_date,
      'test_load' AS _dlt_load_id,
      'test_id_products' AS _dlt_id
  FROM [little-debby].[archive_electrostore].[products];


--check
  SELECT * FROM [little-debby].[archive_electrostore].[products] WHERE product_id = 999999;

--clean up
  DELETE FROM [little-debby].[archive_electrostore].[products] WHERE product_id = 999999;




