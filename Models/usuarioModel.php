<?php

class usuarioModel extends Model
{

    public function obtenerUsuario()
    {
        return $this->_db->query("select *from usuario;")->fetchAll();
    }

    

    public function verificarUsuario($bus){
        $stmt=$this->_db->prepare("SELECT nombre_usuario FROM usuario WHERE nombre_usuario=:bus");
        $stmt->execute(array(':bus'=>$bus));
        $count=$stmt->rowCount();
           
        if($count>0)
        {
         echo "<span id='prueba' estado='false' style='color:brown;'> <strong>Oh no!</strong> Nombre de usuario no disponible !!!</span>";

        }
        else
        {
         echo "<span id='prueba2' style='color:green;'> <strong>Enhorabuena!</strong> Usuario disponible</span>";
        }
      
    }

  

  

    public function insertarUsuario($nombre, $clave, $rol)
    {
        $hash=password_hash($clave, PASSWORD_DEFAULT);
        $this->_db->prepare('insert into usuario(nombre_usuario,clave,rol)
    values(:nombre,:clave,:rol)')->execute(array(
                    'nombre' => $nombre,
                    'clave' => $hash,
                    'rol' => $rol,
                    
                ));

    }

   

    public function borrarU($id)
    {
        $this->_db->prepare('delete from usuario where id_usuario=:id')->execute(array('id' => $id));
    }




}
