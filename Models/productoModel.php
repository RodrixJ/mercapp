<?php

class productoModel extends Model
{

    public function obtenerProducto()
    {
        return $this->_db->query("select *from producto inner join tramo on tramo.id_Tramo=Producto.id_Tramo;")->fetchAll();
    }

    public function obtenerTramo()
    {
        return $this->_db->query("select *from tramo;")->fetchAll();
    }
    

    
    public function insertarProducto($nombre,$marca,$precio,$descripcion,$imagen,$tramo)
    {
       
        $this->_db->prepare('insert into producto(nombre_producto,precio,marca,descripcion,imagen,id_Tramo)
    values(:nombre,:precio,:marca,:desc,:img,:tramo)')->execute(array(
                    'nombre' => $nombre,
                    'precio' => $precio,
                    'marca' => $marca,
                    'desc' => $descripcion,
                    'img' => $imagen,
                    'tramo' => $tramo
                    
                ));

    }

    

    public function insertarProductoSinImagen($nombre,$marca,$precio,$descripcion,$tramo)
    {
       
        $this->_db->prepare('insert into producto(nombre_producto,precio,marca,descripcion,id_Tramo)
    values(:nombre,:precio,:marca,:desc,:tramo)')->execute(array(
                    'nombre' => $nombre,
                    'precio' => $precio,
                    'marca' => $marca,
                    'desc' => $descripcion,
                    'tramo' => $tramo
                    
                ));

    }

  
    public function insertarTramo($tramo,$propietario)
    {
       
        $this->_db->prepare('insert into tramo(nombreTramo,id_Propietario)
    values(:nombre,:propietario)')->execute(array(
                    'nombre' => $tramo,
                    'propietario'=> $propietario
                    
                ));

    }

    public function actualizarMunicipio($id,$departamento, $nombre)
    {
        $sql = 'UPDATE municipio 
        SET nombre_municipio = :nombre,
        departamento_id_departamento = :departamento
        WHERE id_municipio = :id';

        $stmt = $this->_db->prepare($sql);

        $stmt->execute(array(
            'nombre' => $nombre,
            'departamento' => $departamento,
            'id'=> $id
            
        ));

    }

    public function borrarMunicipio($id)
    {
        $this->_db->prepare('delete from municipio where id_municipio=:id')->execute(array('id' => $id));
    }




}
