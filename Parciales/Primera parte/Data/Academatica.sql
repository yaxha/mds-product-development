/* Universidad Galileo
   Maestría en Data Science
   Product Development
   Integrantes: Lilian Rebeca Carrera Lemus
                José Armando Barrios León
   ------------------------------------------
   Archivo de configuración de base de datos y carga de CSVs
   ------------------------------------------
*/

CREATE DATABASE IF NOT EXISTS Academatica;
USE Academatica;

/* --------------------------------------
   Creación de estructura de la base de datos
 --------------------------------------*/
# Información de identificación de los videos publicados
CREATE TABLE IF NOT EXISTS video(
    kind                VARCHAR(20),
    etag                VARCHAR(27),
    youtube_id          VARCHAR(48),
    content_id          VARCHAR(11) PRIMARY KEY NOT NULL,
    fecha_publicacion   DATETIME
);

# Estadísticas de interacción de los videos
CREATE TABLE IF NOT EXISTS stats(
    id              VARCHAR(11) NOT NULL,
    view_count      INT,
    like_count      INT,
    dislike_count   INT,
    favorite_count  INT,
    comment_count   INT,

    FOREIGN KEY (id) REFERENCES video(content_id)
);

# Metadata de videos
CREATE TABLE IF NOT EXISTS metadata(
    id              VARCHAR(11) NOT NULL,
    title           VARCHAR(100),
    description     TEXT,
    iframe          TEXT,
    link            VARCHAR(28),

    FOREIGN KEY (id) REFERENCES video(content_id)
);

SELECT ' - Finalizado: Creación de schema';

#SHOW VARIABLES LIKE "secure_file_priv";
#SHOW GLOBAL VARIABLES LIKE 'local_infile';
/* --------------------------------------
   Carga de datos
 --------------------------------------*/
SET FOREIGN_KEY_CHECKS = 0; 
TRUNCATE TABLE metadata; 
TRUNCATE TABLE stats; 
TRUNCATE TABLE video; 
SET FOREIGN_KEY_CHECKS = 1;
SELECT ' - Finalizado: Vaciado de tablas';

LOAD DATA INFILE '/home/academatica_videos.csv'
REPLACE INTO TABLE video
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(kind, etag, youtube_id, content_id, @fecha_publicacion)
SET fecha_publicacion = STR_TO_DATE(@fecha_publicacion, '%Y-%m-%dT%H:%i:%sZ');
SELECT ' - Finalizado: Carga de video';

LOAD DATA INFILE '/home/academatica_video_stats.csv'
REPLACE INTO TABLE stats
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
SELECT ' - Finalizado: Carga de stats';

#LOAD DATA INFILE '/home/academatica_videos_metadata.csv'
#REPLACE INTO TABLE metadata
#FIELDS TERMINATED BY ','
#LINES TERMINATED BY '\n'
#IGNORE 1 LINES;
#SELECT ' - Finalizado: Carga de metadata';

SELECT ' - Proceso finalizado exitosamente - ';


