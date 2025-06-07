<?php

class departamentoModel extends Model
{

    public function obtenerDepartamento()
    {
        return $this->_db->query("select *from departamento;")->fetchAll();
    }

  
    public function insertarDepartamento($nombre)
    {
       
        $this->_db->prepare('insert into departamento(nombre_departamento)
    values(:nombre)')->execute(array(
                    'nombre' => $nombre
                    
                ));

    }

    public function actualizarDepartamento($id, $nombre)
    {
        $sql = 'UPDATE departamento 
        SET nombre_departamento = :nombre
        WHERE id_departamento = :id';

        $stmt = $this->_db->prepare($sql);

        $stmt->execute(array(
            'nombre' => $nombre,
            'id' => $id
            
        ));

    }

    public function borrarDepartamento($id)
    {
        $this->_db->prepare('delete from departamento where id_departamento=:idDepartamento')->execute(array('idDepartamento' => $id));
    }




}
