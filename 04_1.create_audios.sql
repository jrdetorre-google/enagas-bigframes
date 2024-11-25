------------------------------------------------------------------------------------------------------------
-- Audios (Object Table)
-- previously need to create the connection
------------------------------------------------------------------------------------------------------------
CREATE SCHEMA rideshare_llm_raw

IF NOT EXISTS (SELECT  1
             FROM `rideshare_llm_raw`.INFORMATION_SCHEMA.TABLES
            WHERE table_name = 'biglake_rideshare_audios' 
              AND table_type = 'EXTERNAL')
    THEN
    CREATE OR REPLACE EXTERNAL TABLE `rideshare_llm_raw.biglake_rideshare_audios`
    WITH CONNECTION `us.biglake-connection`
    OPTIONS (
        object_metadata="DIRECTORY",
        uris = ['gs://rideshare-lakehouse-raw-ywvj5mmb31/rideshare_audios/*.mp3'],
        max_staleness=INTERVAL 30 MINUTE, 
        --metadata_cache_mode="AUTOMATIC"
        -- set to Manual for demo
        metadata_cache_mode="MANUAL"
        ); 
END IF;