<?php

class categoriaModel extends Model
{

    public function obtenerCategoria()
    {
        return $this->_db->query("select *from categorias;")->fetchAll();
    }

  
    public function insertarCategoria($nombre)
    {
       
        $this->_db->prepare('insert into categorias(nombre_categoria)
    values(:nombre)')->execute(array(
                    'nombre' => $nombre
                    
                ));

    }

    public function actualizarCategoria($id, $nombre)
    {
        $sql = 'UPDATE categorias 
        SET nombre_categoria = :nombre
        WHERE id = :id';

        $stmt = $this->_db->prepare($sql);

        $stmt->execute(array(
            'nombre' => $nombre,
            'id' => $id
            
        ));

    }

    public function borrarCategoria($idCategoria)
    {
        $this->_db->prepare('delete from categorias where id=:idCategoria')->execute(array('idCategoria' => $idCategoria));
    }




}
