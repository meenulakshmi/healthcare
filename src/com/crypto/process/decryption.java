package com.crypto.process;


import java.math.BigInteger;
import java.sql.*;
//import java.util.Map;


public class decryption 
{

	public static void main(String[] args) 
	{
	  try
	   {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project1","root","");
		Statement st=con.createStatement();
		//Statement st1=con.createStatement();
		String sql= "SELECT * FROM project_crypt where pid = 8567";
		//String sql1= null;
		ResultSet rs=st.executeQuery(sql);
		System.out.println("hi");
		while (rs.next()) 
		{
			System.out.println("hi1");
			 int pid = rs.getInt("pid");
			 System.out.println("hi"+pid);
			 String name = rs.getString("name");
			 System.out.println("hi"+name);
			 
			 String[] Publickey_crypt = rs.getString("Publickey_crypt").split("-");
			 String[] Privatekey_crypt = rs.getString("privatekey_crypt").split("-");
			 System.out.println(rs.getString("Publickey_crypt"));
			 int publickey_bits = Integer.parseInt(Publickey_crypt[0]);
			 System.out.println("publickey_bits"+publickey_bits);
			 BigInteger publickey_n = new BigInteger(Publickey_crypt[1]);
			 System.out.println("publickey_n"+publickey_n);
			 BigInteger publickey_nSquared = new BigInteger(Publickey_crypt[2]);
			 System.out.println("publickey_nSquared"+publickey_nSquared);
			 BigInteger publickey_g = new BigInteger(Publickey_crypt[3]);
			 System.out.println("publickey_g"+publickey_g);
			 BigInteger privatekey_lambda=new BigInteger(Privatekey_crypt[0]);
			 BigInteger privatekey_preCalculatedDenominator = new BigInteger(Privatekey_crypt[1]);

            
			 PublicKey publicKey = new PublicKey(publickey_n,publickey_nSquared,publickey_g,publickey_bits);
			 PrivateKey privateKey=new PrivateKey(privatekey_lambda,privatekey_preCalculatedDenominator);
			 KeyPair keyPair = new KeyPair(privateKey,publicKey,null);
             
             System.out.println("hi");
			 
			 BigInteger bp_systole_cipher = new BigInteger (rs.getString("bp_systole_crypt"));
			 System.out.println("decryptedData"+bp_systole_cipher);
			 BigInteger decryptedData_bp_systole = keyPair.decrypt(bp_systole_cipher);
			 System.out.println("decryptedData"+decryptedData_bp_systole);
			    
		}
		st.close();
		con.close();
	   }
	  catch(Exception e)
	    {
	     e.printStackTrace();
	    }
	}
  
}