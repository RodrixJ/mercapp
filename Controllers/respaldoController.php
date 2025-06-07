<?php
class respaldoController extends Controller
{
    private $_respaldo;

    function __construct()
    {
        parent::__construct();
        $this->_respaldo = $this->loadModel("respaldo");
    }


    


    public function index()
    {
       
        Sessiones::acceso('administrador');

        $this->_view->renderizar('respaldo');
    }


    public function respaldo(){
    
	


        $host="localhost";
        $username="root";
        $password="";
        $database_name="memorialdb";
        
        $conn=mysqli_connect($host,$username,$password,$database_name);
        
        $tables=array();
        $sql="SHOW TABLES";
        $result=mysqli_query($conn,$sql);
        
        while($row=mysqli_fetch_row($result)){
        $tables[]=$row[0];
        }
        
        $backupSQL="";
        foreach($tables as $table){
        $query="SHOW CREATE TABLE $table";
        $result=mysqli_query($conn,$query);
        $row=mysqli_fetch_row($result);
        $backupSQL.="\n\n".$row[1].";\n\n";
        
        $query="SELECT * FROM $table";
        $result=mysqli_query($conn,$query);
        
        $columnCount=mysqli_num_fields($result);
        
        for($i=0;$i<$columnCount;$i++){
        while($row=mysqli_fetch_row($result)){
        $backupSQL.="INSERT INTO $table VALUES(";
        for($j=0;$j<$columnCount;$j++){
        $row[$j]=$row[$j];
        
        if(isset($row[$j])){
        $backupSQL.='"'.$row[$j].'"';
        }else{
        $backupSQL.='""';
        }
        if($j<($columnCount-1)){
        $backupSQL.=',';
        }
        }
        $backupSQL.=");\n";
        }
        }
        $backupSQL.="\n";
        }
        
        if(!empty($backupSQL)){
        $backup_file_name=$database_name.'_backup_'.time().'.sql';
        $fileHandler=fopen($backup_file_name,'w+');
        $number_of_lines=fwrite($fileHandler,$backupSQL);
        fclose($fileHandler);
        
        header('Content-Description: File Transfer');
        header('Content-Type: application/octet-stream');
        header('Content-Disposition: attachment; filename='.basename($backup_file_name));
        header('Content-Transfer-Encoding: binary');
        header('Expires: 0');
        header('Cache-Control: must-revalidate');
        header('Pragma: public');
        header('Content-Length: '.filesize($backup_file_name));
        readfile($backup_file_name);
        }
        
        
        
        
        
        
        
           
        
        }





    





}




?>