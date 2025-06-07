<?php

class recuerdoModel extends Model
{

    public function obtenerDatosFamiliar($usuario)
    {
        return $this->_db->query("select *from familiar where usuario='$usuario';")->fetchAll();
    }

    public function obtenerDefuncion($id)
    {
        return $this->_db->query("select * from defunciones where id_defuncion='$id';")->fetchAll();
    }

  
    public function ingresarRecuerdo($id,$recuerdo,$image){
    $this->_db->prepare('insert into galeria
    (recurso,descripcion_recuerdo,defuncion_id_defuncion)
    values
    (:recurso,:recuerdo,:id)')->execute(array('recurso'=>$image,'recuerdo'=>$recuerdo,
    'id'=>$id));
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
