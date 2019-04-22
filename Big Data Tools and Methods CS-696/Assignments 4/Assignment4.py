def files_from_args(): 
	import argparse
	parser = argparse.ArgumentParser() 
	parser.add_argument('-f', '--file', default='file')
	parser.add_argument('-c', '--column', default='column') 
	parser.add_argument('-o', '--output',default='output') 

	args = parser.parse_args() 
	return (args.file, args.column, args.output) 


def gradandclearthedat(file_path,heaher_path):
    from pyspark.sql import SparkSession
    spark = SparkSession.builder.getOrCreate()
    
    reader = spark.read 
    reader.option("header",True) 
    reader.option("inferSchema",True) 
    reader.option("sep", "|") 
    donation_df = reader.csv(file_path)

    reader = spark.read 
    reader.option("header",True) 
    reader.option("inferSchema",True) 
    reader.option("delimter", "|") 
    header_df = reader.csv(heaher_path)
    donation_df =  donation_df.toDF(*header_df.columns)
    donation_df = donation_df.select("CMTE_ID","TRANSACTION_TP","ENTITY_TP","TRANSACTION_AMT")
    return donation_df


def count_donation(donation_df,output):
    import pyspark.sql.functions as sparkfun
    donation_transaction_list =["15","15E","17R","18K","18L","18U","19"]    
    donation_df = donation_df[donation_df.TRANSACTION_TP.isin( donation_transaction_list)]
    three_cand_count = donation_df.groupBy('CMTE_ID').agg( sparkfun.count('CMTE_ID'))
    result_1 = three_cand_count[three_cand_count.CMTE_ID.isin(["C00575795","C00577130","C00580100"])]
    print("The count of donations for each campaign")
    result_1.show()
    result_1 = result_1.repartition(1)
    count_output = output + "-count"
    result_1.write.format('csv').save(count_output)   
    return donation_df



def amount_donation(donation_df,output):
    import pyspark.sql.functions as sparkfun
    three_cand_amt = donation_df.groupBy('CMTE_ID').agg( sparkfun.sum('TRANSACTION_AMT') )
    result_2 = three_cand_amt[three_cand_amt.CMTE_ID.isin(["C00575795","C00577130","C00580100"])]
    
    print("The amount of donations for each campaign")
    result_2.show()
    result_2 = result_2.repartition(1)
    amount_output = output + "-amount"
    result_2.write.format('csv').save(amount_output)


def percentage_donation(donation_df,output):
	import pyspark.sql.functions as sparkfun
	ind_df = donation_df.groupBy("CMTE_ID", "ENTITY_TP").agg( sparkfun.count('CMTE_ID') ).where((sparkfun.col("CMTE_ID") == "C00575795") | (sparkfun.col("CMTE_ID") == "C00577130") |                (sparkfun.col("CMTE_ID") == "C00580100") & (sparkfun.col("ENTITY_TP") == "IND"))
	total_entity_df = donation_df.groupBy("CMTE_ID").agg( sparkfun.count('ENTITY_TP') ).where((sparkfun.col("CMTE_ID") == "C00575795") | (sparkfun.col("CMTE_ID") == "C00577130") |                (sparkfun.col("CMTE_ID") == "C00580100"))
	result_3 =  ind_df.join(total_entity_df, on=["CMTE_ID"])
	result_3 = result_3.withColumn('percentage',result_3["count(CMTE_ID)"]/result_3["count(ENTITY_TP)"] )

	print("The percentage of small contributors each campaign")
	result_3.show()
	result_3 = result_3.repartition(1)
	percentage_output = output + "-percentage"
	result_3.write.format('csv').save(percentage_output)    

	
if __name__ == "__main__": 
    file_path, heaher_path,output = files_from_args() 
    donation_df = gradandclearthedat(file_path,heaher_path)
    donation_df = count_donation(donation_df,output)  
    amount_donation(donation_df,output)
    percentage_donation(donation_df,output)    
