<?php

class operarioModel extends Model
{

    public function obtenerOperario()
    {
        return $this->_db->query("select *from operarios inner join cementerio on cementerio_id_cementerio=id_cementerio;")->fetchAll();
    }


    public function obtenerCementerio()
    {
        return $this->_db->query("select *from cementerio;")->fetchAll();
    }


    public function insertarOperario($nombre,$telefono,$estado,$especialidad,$cementerio,$direccion,$imagen,$user,$pass)
    {
       
        $this->_db->prepare('insert into operarios(nombre_completo,telefono,direccion,estado,especialidad,imagenOperario,cementerio_id_cementerio)
    values(:nombre,:telefono,:direccion,:estado,:especialidad,:imagen,:cementerio)')->execute(array(
                    'nombre' => $nombre,
                    'telefono' => $telefono,
                    'direccion' => $direccion,
                    'estado' => $estado,
                    'especialidad' => $especialidad,
                    'imagen' => $imagen,
                    'cementerio' => $cementerio
                    
                ));

                $privilegio="operario";
                $hash=password_hash($pass, PASSWORD_DEFAULT);

                $this->_db->prepare('insert into usuario(nombre_usuario,clave,rol)
    values(:nombre,:clave,:rol)')->execute(array(
                    'nombre' => $user,
                    'clave' => $hash,
                    'rol' => $privilegio
                    
                ));

    }

  

    





}
