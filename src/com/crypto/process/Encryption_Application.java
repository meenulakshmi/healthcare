	package com.crypto.process;


	import java.math.BigInteger;
	import java.sql.*;
	import java.lang.Object;

	public class Encryption_Application 
	{

		public static void main(String[] args) 
		{
		  try
		   {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project1","root","");
			Statement st=con.createStatement();
			Statement st1=con.createStatement();
			//String sql= "SELECT * FROM project order by pid ";
			//String sql= "SELECT * FROM project where pid in(8316,8541,8542 )order by pid ";
			//String sql= "SELECT * FROM project where time > current timestamp - 10 minutes order by pid ";
			String sql= "SELECT * FROM project where pid = 8316 order by pid ";
			String sql1= null;
			ResultSet rs=st.executeQuery(sql);
			System.out.println("hi");
			while (rs.next()) 
			{
				System.out.println("hi1");
				 int pid = rs.getInt("pid");
				 System.out.println("hi"+pid);
				 String name = rs.getString("name");
			//	 System.out.println("hi"+str1);
				 int hr = rs.getInt("hr");
			//	 System.out.println("hi"+hr);
				 int br = rs.getInt("br");
		   //		 System.out.println("hi"+br);
				 int bp_systole = rs.getInt("bp_systole");
				 System.out.println("bp_systole"+bp_systole);
		  		 int bp_diastole = rs.getInt("bp_diastole");
			//	 System.out.println("hi"+bp_diastole);
				 int ecg = rs.getInt("ecg");
				 int spo2 = rs.getInt("spo2");
				 String time = rs.getString("time");
				 String location_crypt = rs.getString("location");
				 String activity_crypt = rs.getString("activity");
				 int did_crypt = rs.getInt("did");
			//	 System.out.println("hi"+ecg);
				 //int spo2 = rs.getInt("spo2");
				 KeyPair keyPair;
	             PublicKey publicKey;// display purpose
	             PrivateKey privateKey;// display purpose
				 KeyPairBuilder keygen = new KeyPairBuilder();
				 keyPair = keygen.generateKeyPair();
				 System.out.println("hi");
				 publicKey = keyPair.getPublicKey();
				 privateKey = keyPair.getPrivateKey();
				 System.out.println("privateKey"+privateKey);
				 
				 String publicKey_crypt = publicKey.getBits()+"-"+publicKey.getN()+"-"+
						                  publicKey.getnSquared()+"-"+publicKey.getG();
				 String privateKey_crypt = privateKey.getLambda()+"-"+privateKey.getPreCalculatedDenominator();                                  
				 
                 System.out.println("publicKey_crypt"+publicKey_crypt);
                 System.out.println("publicKey_crypt"+publicKey_crypt);
				 
                 BigInteger plainData,encryptedData = null;
                 
                 plainData = BigInteger.valueOf(hr);
		         System.out.println("plainData "+plainData);
			     encryptedData = publicKey.encrypt(plainData);
			     System.out.println("encryptedData"+encryptedData);
			     String hr_crypt = String.valueOf(encryptedData);
                 
			     plainData = BigInteger.valueOf(br);
		         System.out.println("plainData "+plainData);
			     encryptedData = publicKey.encrypt(plainData);
			     System.out.println("encryptedData"+encryptedData);
			     String br_crypt = String.valueOf(encryptedData);
                 
			     
				 plainData = BigInteger.valueOf(bp_systole);
		         System.out.println("plainData "+plainData);
			     encryptedData = publicKey.encrypt(plainData);
			     System.out.println("encryptedData"+encryptedData);
			     String bp_systole_crypt = String.valueOf(encryptedData);
			     
			     plainData = BigInteger.valueOf(bp_diastole);
		         System.out.println("plainData "+plainData);
			     encryptedData = publicKey.encrypt(plainData);
			     System.out.println("encryptedData"+encryptedData);
			     String bp_diastole_crypt = String.valueOf(encryptedData);
			    
			     plainData = BigInteger.valueOf(ecg);
		         System.out.println("plainData "+plainData);
			     encryptedData = publicKey.encrypt(plainData);
			     System.out.println("encryptedData"+encryptedData);
			     String ecg_crypt = String.valueOf(encryptedData);
			    
			     plainData = BigInteger.valueOf(spo2);
		         System.out.println("plainData "+plainData);
			     encryptedData = publicKey.encrypt(plainData);
			     System.out.println("encryptedData"+encryptedData);
			     String spo2_crypt = String.valueOf(encryptedData);
			    
			      
			     System.out.println("PID"+pid);
			     System.out.println("PNAME"+name);
			     sql1 = "INSERT INTO project_crypt " +
		                   "VALUES ('"+pid+"',"
		                   		+ "'"+name+"',"
		                   		+ "'"+time+"',"
		                   		+ "'"+hr_crypt+"',"
		                   		+ "'"+br_crypt+"',"
		                   		+ "'"+bp_systole_crypt+"',"
		                   		+ "'"+bp_diastole_crypt+"',"
		                   		+ "'"+publicKey_crypt+"',"
		                   		+ "'"+privateKey_crypt+"',"
		                   		+ "'"+ecg_crypt+"',"
		                   		+ "'"+spo2_crypt+"',"
		                   		+ "'"+location_crypt+"',"
		                   		+ "'"+activity_crypt+"',"
		                   		+ "'"+did_crypt+"')";
			     st1.executeUpdate(sql1);

			    BigInteger decryptedData = keyPair.decrypt(encryptedData);
			    System.out.println("decryptedData"+decryptedData);
			     		     
			     
				 BigInteger plainData1 = BigInteger.valueOf(bp_diastole);
		         System.out.println("plainData "+plainData1);
			     BigInteger encryptedData1 = publicKey.encrypt(plainData1);
			     System.out.println("encryptedData"+encryptedData1);
			     BigInteger decryptedData1= keyPair.decrypt(encryptedData1);
			     System.out.println("decryptedData"+decryptedData1);     

			 
				 
			}
			st.close();
		 	st1.close();
			con.close();
		   }
		  catch(Exception e)
		    {
		     e.printStackTrace();
		    }
		/*  
		KeyPair keyPair;
	    PublicKey publicKey; 

	     KeyPairBuilder keygen = new KeyPairBuilder();
	     keyPair = keygen.generateKeyPair();
	     System.out.println("hi");

	     publicKey = keyPair.getPublicKey();
	     System.out.println("publicKey"+publicKey);
	     BigInteger plainData = BigInteger.valueOf(10);
	     System.out.println("hi"+plainData);
	     BigInteger encryptedData = publicKey.encrypt(plainData);
	     System.out.println("hi"+encryptedData);
	     BigInteger decryptedData = keyPair.decrypt(encryptedData);
	     System.out.println("hi"+decryptedData);     
	     */
		}
	  
	}