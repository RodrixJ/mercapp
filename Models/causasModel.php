<?php

class causasModel extends Model
{

    public function obtenerCausas()
    {
        return $this->_db->query("select *from causas inner join categorias on categorias.id=categoria_id;")->fetchAll();
    }

    public function obtenerCategoria()
    {
        return $this->_db->query("select * from categorias;")->fetchAll();
    }


    public function insertarCausa($codigoCIE, $nombreCategoria, $descripcion)
    {
        $this->_db->prepare('insert into causas(codigo,descripcion,categoria_id)
    values(:codigo,:descripcion,:categoria_id)')->execute(array(
                    'codigo' => $codigoCIE,
                    'descripcion' => $descripcion,
                    'categoria_id' => $nombreCategoria
                ));

    }

    public function actualizarCausa($id, $codigo, $idCategoria, $descripcion)
    {
        $sql = 'UPDATE causas 
        SET codigo = :codigo, 
            descripcion = :descripcion, 
            categoria_id = :categoria
           
        WHERE id_causa = :id';

        $stmt = $this->_db->prepare($sql);

        $stmt->execute(array(
            'codigo' => $codigo,
            'descripcion' => $descripcion,
            'categoria' => $idCategoria,
            'id' => $id
            
        ));

    }

    public function borrarCausa($idCausa)
    {
        $this->_db->prepare('delete from causas where id_causa=:idCausa')->execute(array('idCausa' => $idCausa));
    }




}
