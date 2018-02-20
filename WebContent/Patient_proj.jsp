<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.*,java.util.*,java.text.*,java.math.BigInteger" %>
<%@ page import="com.crypto.process.PublicKey" %>
<%@ page import="com.crypto.process.PrivateKey" %>
<%@ page import="com.crypto.process.KeyPair" %>
<%
//out.println("hi"+request.getParameter("pid"));
int pat_id = Integer.parseInt(request.getParameter("pid"));

//Start_date converted as per DB format (YYYY-MM-DD)
String beg_date = request.getParameter("start_date");
//out.println("Beg_Date"+beg_date);

//End_date converted as per DB format (YYYY-MM-DD)
String end_date = request.getParameter("end_date");
//out.println("End_Date"+end_date);


//DB2 connection:
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project","root","lakshmi");
Statement st=con.createStatement();

out.println(" <div align='center'>" +"<font size='5'>" + " Patient Medical Details: </font>" +"</div>");
out.println("<table>");
out.println("<tr>")	;
			out.println(
			    "<th>" + "Date " +"</th>   " +
			    "<th>" + "Minimum Blood Pressure " +"</th>   " +
	            "<th>"+  "Maximum Blood Pressure "+ "</th>   " +
	            "<th>"+  "Minimum heart rate "+ "</th>       " +
	            "<th>"+  "Maximum heart rate "+ "</th>       " +
	            "<th>"+  "Minimum breath rate "+ "</th>      " +
	            "<th>"+  "Maximum breath rate "+ "</th>      " +
	            "<th>"+  "Minimum EcG "+ "</th>              " +
	            "<th>"+  "Maximum EcG "+ "</th>              " 
	                   );
out.println("</br>");
out.println("</tr>");

	try
	{        
	        //int data_present = 0;
         
            String sql = "select date(time) as time , bp_systole_crypt , bp_diastole_crypt, hr_crypt , br_crypt , ecg_crypt,Publickey_crypt,privatekey_crypt from project_crypt " + 
            		       "where pid = "+ pat_id+
            		       " AND ( date(time) between CAST('"+beg_date+"' AS DATE) AND CAST('"+end_date + "' AS DATE))"
            		       + "ORDER BY TIME";
            //out.println(sql);
            
	 		ResultSet rs=st.executeQuery(sql);
	 		
	 		ArrayList<Integer> Min_BP = new ArrayList<Integer>();
	 		ArrayList<Integer> Max_BP = new ArrayList<Integer>();
	 		ArrayList<Integer> Min_Max_HR = new ArrayList<Integer>();
	 	    ArrayList<Float> Min_Max_BR = new ArrayList<Float>();
	 	    ArrayList<Integer> Min_Max_ECG = new ArrayList<Integer>();
	 	   String decryptedData_bp_systole = null;
	 	   String decryptedData_bp_diastole = null;
	 	   String decryptedData_hr= null;
	 	   String decryptedData_br= null;
	 	   String decryptedData_ecg= null;
	 		 		
	 		int data_present = 0;
	 		boolean first_time = true;
	 		String prev_date = null; 
	 		String current_date =null;
	 		
	    	while(rs.next())     
	   		{   
	    		//out.println("current_date"+current_date);
	    		current_date = rs.getString("time");
	    		//out.println("current_date"+current_date);
	    		if (first_time == true)
	    		{
	    			prev_date = current_date ;
	    			first_time = false;
	    		}
	    		
	    		
	    		if( prev_date.equals(current_date))
	    		{
	    		 //out.println("data added");
	    		 
    		 String[] Publickey_crypt = rs.getString("Publickey_crypt").split("-");
			 String[] Privatekey_crypt = rs.getString("privatekey_crypt").split("-");
			 //out.println(rs.getString("Publickey_crypt"));
			 int publickey_bits = Integer.parseInt(Publickey_crypt[0]);
			 //out.println("publickey_bits"+publickey_bits);
			 BigInteger publickey_n = new BigInteger(Publickey_crypt[1]);
			 //out.println("publickey_n"+publickey_n);
			 BigInteger publickey_nSquared = new BigInteger(Publickey_crypt[2]);
			 //out.println("publickey_nSquared"+publickey_nSquared);
			 BigInteger publickey_g = new BigInteger(Publickey_crypt[3]);
			 //out.println("publickey_g"+publickey_g);
			 BigInteger privatekey_lambda=new BigInteger(Privatekey_crypt[0]);
			 BigInteger privatekey_preCalculatedDenominator = new BigInteger(Privatekey_crypt[1]);

            
			 PublicKey publicKey = new PublicKey(publickey_n,publickey_nSquared,publickey_g,publickey_bits);
			 PrivateKey privateKey=new PrivateKey(privatekey_lambda,privatekey_preCalculatedDenominator);
			 KeyPair keyPair = new KeyPair(privateKey,publicKey,null);

			 BigInteger bp_systole_cipher = new BigInteger (rs.getString("bp_systole_crypt"));
			// out.println("decryptedData"+bp_systole_cipher);
			 decryptedData_bp_systole = (String.valueOf(keyPair.decrypt(bp_systole_cipher)));
			// out.println("decryptedData"+decryptedData_bp_systole);
			 
			 BigInteger bp_diastole_cipher = new BigInteger (rs.getString("bp_diastole_crypt"));
			// out.println("decryptedData"+bp_systole_cipher);
			 decryptedData_bp_diastole = (String.valueOf(keyPair.decrypt(bp_diastole_cipher)));
			// out.println("decryptedData"+decryptedData_bp_diastole);
			 
			 BigInteger hr_cipher = new BigInteger (rs.getString("hr_crypt"));
			// out.println("decryptedData"+hr_cipher);
			 decryptedData_hr = (String.valueOf(keyPair.decrypt(hr_cipher)));
			// out.println("decryptedData"+decryptedData_hr);
			 
			 BigInteger br_cipher = new BigInteger (rs.getString("br_crypt"));
			 //out.println("decryptedData"+br_cipher);
			 decryptedData_br = (String.valueOf(keyPair.decrypt(br_cipher)));
			 //out.println("decryptedData"+decryptedData_br);
			 
			 BigInteger ecg_cipher = new BigInteger (rs.getString("ecg_crypt"));
			 //out.println("decryptedData"+ecg_cipher);
			 decryptedData_ecg = (String.valueOf(keyPair.decrypt(ecg_cipher))) ;
			 //out.println("decryptedData"+decryptedData_ecg);
			 		    
	    		 
	    		 Max_BP.add(Integer.valueOf(decryptedData_bp_systole));
	    		 Min_BP.add(Integer.valueOf(decryptedData_bp_diastole));
	    		 Min_Max_BR.add(Float.valueOf(decryptedData_br));
	    		 Min_Max_HR.add(Integer.valueOf(decryptedData_hr));
	    		 Min_Max_ECG.add(Integer.valueOf(decryptedData_ecg));
	    		 	    		 
	    		 data_present = 1;
	    //		 out.println("data_present-xx"+data_present);
	    		}
	 	//out.println(rs.getString("bp_systole"));
	 	        else
	 	        {  
	 	 //          out.println("data_present"+data_present);
		 		   if (data_present == 1)
		    	   {
		 	//		  out.println("data added1");
		   		      int min_bp =  Collections.min(Min_BP);
		   		      int max_bp = Collections.max(Max_BP);
		   		      int min_hr = Collections.min(Min_Max_HR);
		   		      int max_hr = Collections.min(Min_Max_HR);
		   		      float min_br = Collections.min(Min_Max_BR);
		   		      float max_br = Collections.min(Min_Max_BR);
		   		      int min_ecg = Collections.min(Min_Max_ECG);
		   		      int max_ecg = Collections.min(Min_Max_ECG);
		   		      out.println("<tr>");
		   		      out.println(
		   		       "<td>" + prev_date +"</td>" +
		   		       "<td>" + min_bp       +"</td>" +
		               "<td>"+  max_bp       +"</td>" + 
		               "<td>"+  min_hr       +"</td>" +
		               "<td>"+  max_hr       +"</td>" +
		               "<td>"+  min_br       +"</td>" +
		               "<td>"+  max_br       +"</td>" +
		               "<td>"+  min_ecg      +"</td>" +
		               "<td>"+  max_ecg      +"</td>" 
		                         );
		   		      out.println("</tr>");
		   		      
		   		     data_present = 0;
		   		     Min_BP.clear();
		   		     Max_BP.clear();
		   		     Min_Max_HR.clear();
		   		     Min_Max_BR.clear();
		   		     Min_Max_ECG.clear();
		   		     
		   		     Max_BP.add(Integer.valueOf(decryptedData_bp_diastole));
		    		 Min_BP.add(Integer.valueOf(decryptedData_bp_systole));
		    		 Min_Max_BR.add(Float.valueOf(decryptedData_br));
		    		 Min_Max_HR.add(Integer.valueOf(decryptedData_hr));
		    		 Min_Max_ECG.add(Integer.valueOf(decryptedData_ecg));
		    		  
		   		     
		    		 data_present = 1;
		    	   }
	 	        }
	    		prev_date = current_date; 
	   		}
	    //	out.println(data_present+"aaz");
	    	if (data_present == 1)
	    	{	
	    //		out.println("data added2");
	    		int min_bp = Collections.min(Min_BP);
	    		int max_bp = Collections.max(Max_BP);
	    		int min_hr = Collections.min(Min_Max_HR);
	    		int max_hr = Collections.max(Min_Max_HR);
	    		float min_br = Collections.min(Min_Max_BR);
	    		float max_br = Collections.max(Min_Max_BR);
	    		int min_ecg = Collections.min(Min_Max_ECG);
	    		int max_ecg = Collections.max(Min_Max_ECG);
	   		  
	    	//   out.println("Min_BP"+Collections.min(Min_BP));
	   		   out.println("<tr>");
	   		  
	   		  out.println(
		   		       "<td>" + prev_date +"</td>" +
		   		       "<td>" + min_bp       +"</td>" +
		               "<td>"+  max_bp       +"</td>" +
		               "<td>"+  min_hr       +"</td>" +
		               "<td>"+  max_hr       +"</td>" +
		               "<td>"+  min_br       +"</td>" +
		               "<td>"+  max_br       +"</td>" +
		               "<td>"+  min_ecg      +"</td>" +
		               "<td>"+  max_ecg      +"</td>" 
		                 );
	   		  
	   		  out.println("</tr>");
	   		      
	   		  data_present = 0;
	   		  Min_BP.clear();
  		      Max_BP.clear();
  		      Min_Max_HR.clear();
  		      Min_Max_BR.clear();
  		      Min_Max_ECG.clear();
  		     
	   		   
	        }
 	 	
	   
	   out.println("</table>");     
	   
				
  
        st.close();
        con.close();
    }
    catch(Exception e)
    {
     e.printStackTrace();
    }

%>
