
DROP TABLE IF EXISTS ehr_schema.patients;
CREATE TABLE ehr_schema.patients (	
   subject_id INT NOT NULL UNIQUE,
   gender VARCHAR(255) NOT NULL,	
   anchor_age SMALLINT NOT NULL,	
   anchor_year SMALLINT NOT NULL,	
   anchor_year_group VARCHAR(255) NOT NULL,	
   dod DATE)


DROP TABLE IF EXISTS ehr_schema.admissions;
CREATE TABLE ehr_schema.admissions (	
   subject_id INT NOT NULL,	
   hadm_id INT NOT NULL PRIMARY KEY,	
   admittime DATETIME2 NOT NULL,
   dischtime DATETIME2 NOT NULL,
   deathtime DATETIME2,
   admission_type VARCHAR(255) NOT NULL,	
   admit_provider_id VARCHAR(10),
   admission_location VARCHAR(255) NOT NULL,	
   discharge_location VARCHAR(255),	
   insurance VARCHAR(255) NOT NULL,	
   language VARCHAR(255) NOT NULL,	
   marital_status VARCHAR(255),	
   race VARCHAR(255) NOT NULL,	
   edregtime DATETIME2,
   edouttime DATETIME2,
   hospital_expire_flag BIT NOT NULL	
  )

DROP TABLE IF EXISTS ehr_schema.icustays;
CREATE TABLE ehr_schema.icustays (	
   subject_id INT NOT NULL,	
   hadm_id INT NOT NULL,	
   stay_id INT NOT NULL PRIMARY KEY,	
   first_careunit VARCHAR(255) NOT NULL,	
   last_careunit VARCHAR(255) NOT NULL,	
   intime DATETIME2 NOT NULL,
   outtime DATETIME2 NOT NULL,
   los FLOAT NOT NULL)

DROP TABLE IF EXISTS ehr_schema.caregiver;
CREATE TABLE ehr_schema.caregiver (	
   caregiver_id INT NOT NULL PRIMARY KEY
  )

DROP TABLE IF EXISTS ehr_schema.chartevents;
CREATE TABLE ehr_schema.chartevents (          
   subject_id   INT NOT NULL,       
   hadm_id      INT NOT NULL,       
   stay_id      INT NOT NULL,       
   caregiver_id INT,
   charttime    DATETIME2 NOT NULL,
   storetime    DATETIME2,
   itemid       INT NOT NULL, 
   value        varchar(156),       
   valuenum     FLOAT,
   valueuom     VARCHAR(255),       
   warning      BIT         ,        
   PRIMARY KEY (subject_id, hadm_id, stay_id, itemid, charttime)
  )

DROP TABLE IF EXISTS ehr_schema.d_hcpcs;
CREATE TABLE ehr_schema.d_hcpcs (	
   code VARCHAR(255) NOT NULL PRIMARY KEY ,	
   category SMALLINT,	
   long_description varchar(1182),	
   short_description varchar(165) NOT NULL	
  )

DROP TABLE IF EXISTS ehr_schema.d_icd_diagnoses;
CREATE TABLE ehr_schema.d_icd_diagnoses (	
   icd_code VARCHAR(255) NOT NULL,	
   icd_version SMALLINT NOT NULL,	
   long_title varchar(228) NOT NULL	
  )

DROP TABLE IF EXISTS ehr_schema.d_icd_procedures;
CREATE TABLE ehr_schema.d_icd_procedures (	
   icd_code VARCHAR(255) NOT NULL PRIMARY KEY ,	
   icd_version SMALLINT NOT NULL,	
   long_title varchar(163) NOT NULL	
  )

DROP TABLE IF EXISTS ehr_schema.d_items;
CREATE TABLE ehr_schema.d_items (	
   itemid INT NOT NULL PRIMARY KEY,	
   label varchar(95) NOT NULL,	
   abbreviation VARCHAR(255) NOT NULL,	
   linksto VARCHAR(255) NOT NULL,	
   category VARCHAR(255) NOT NULL,	
   unitname VARCHAR(255),	
   param_type VARCHAR(255) NOT NULL,	
   lownormalvalue SMALLINT,	
   highnormalvalue FLOAT)

DROP TABLE IF EXISTS ehr_schema.d_labitems;
CREATE TABLE ehr_schema.d_labitems (	
   itemid INT NOT NULL PRIMARY KEY,	
   label VARCHAR(255),	
   fluid VARCHAR(255) NOT NULL,	
   category VARCHAR(255) NOT NULL	
  )


DROP TABLE IF EXISTS ehr_schema.datetimeevents;
CREATE TABLE ehr_schema.datetimeevents (	
   subject_id INT NOT NULL,	
   hadm_id INT NOT NULL,	
   stay_id INT NOT NULL,	
   caregiver_id INT,
   charttime DATETIME2 NOT NULL,
   storetime DATETIME2 NOT NULL,
   itemid INT NOT NULL,	
   value DATETIME2 NOT NULL,
   valueuom VARCHAR(255) NOT NULL,	
   warning BIT NOT NULL,	
  )

DROP TABLE IF EXISTS ehr_schema.diagnoses_icd;
CREATE TABLE ehr_schema.diagnoses_icd (	
   subject_id INT NOT NULL,	
   hadm_id INT NOT NULL,	
   seq_num SMALLINT NOT NULL,	
   icd_code VARCHAR(255) NOT NULL,	
   icd_version SMALLINT NOT NULL,	
  )

DROP TABLE IF EXISTS ehr_schema.drgcodes;
CREATE TABLE ehr_schema.drgcodes (	
   subject_id INT NOT NULL,	
   hadm_id INT NOT NULL,	
   drg_type VARCHAR(255) NOT NULL,	
   drg_code VARCHAR(255) NOT NULL,	
   description varchar(89) NOT NULL,	
   drg_severity SMALLINT,	
   drg_mortality SMALLINT,	
  )


DROP TABLE IF EXISTS ehr_schema.emar;
CREATE TABLE ehr_schema.emar (	
   subject_id INT NOT NULL,	
   hadm_id INT,	
   emar_id VARCHAR(255) NOT NULL PRIMARY KEY,	
   emar_seq INT NOT NULL,	
   poe_id VARCHAR(255) NOT NULL,	
   pharmacy_id INT,	
   enter_provider_id VARCHAR(255),
   charttime DATETIME2 NOT NULL,
   medication VARCHAR(255),	
   event_txt VARCHAR(255),	
   scheduletime DATETIME2,
   storetime DATETIME2 NOT NULL)


DROP TABLE IF EXISTS ehr_schema.emar_detail;
CREATE TABLE ehr_schema.emar_detail (	
   subject_id INT NOT NULL,	
   emar_id VARCHAR(255) NOT NULL,	
   emar_seq INT NOT NULL,	
   parent_field_ordinal FLOAT,
   administration_type VARCHAR(255),	
   pharmacy_id INT,	
   barcode_type VARCHAR(255),	
   reason_for_no_barcode VARCHAR(255),	
   complete_dose_not_given VARCHAR(255),	
   dose_due VARCHAR(255),	
   dose_due_unit VARCHAR(255),	
   dose_given VARCHAR(255),	
   dose_given_unit VARCHAR(255),	
   will_remainder_of_dose_be_given VARCHAR(255),	
   product_amount_given VARCHAR(255),	
   product_unit VARCHAR(255),	
   product_code VARCHAR(255),	
   product_description varchar(129),	
   product_description_other varchar(97),	
   prior_infusion_rate VARCHAR(255),	
   infusion_rate VARCHAR(255),	
   infusion_rate_adjustment VARCHAR(255),	
   infusion_rate_adjustment_amount VARCHAR(255),	
   infusion_rate_unit VARCHAR(255),	
   route VARCHAR(255),	
   infusion_complete VARCHAR(255),	
   completion_interval VARCHAR(255),	
   new_iv_bag_hung VARCHAR(255),	
   continued_infusion_in_other_location VARCHAR(255),	
   restart_interval VARCHAR(255),	
   side VARCHAR(255),	
   site VARCHAR(255),	
   non_formulary_visual_verification VARCHAR(255),	
  )


DROP TABLE IF EXISTS ehr_schema.hcpcsevents;
CREATE TABLE ehr_schema.hcpcsevents (	
   subject_id INT NOT NULL,	
   hadm_id INT NOT NULL,	
   chartdate DATE NOT NULL,
   hcpcs_cd VARCHAR(255) NOT NULL,	
   seq_num SMALLINT NOT NULL,	
   short_description varchar(165) NOT NULL,	
   PRIMARY KEY (subject_id, hadm_id, chartdate, hcpcs_cd)
  )



DROP TABLE IF EXISTS ehr_schema.ingredientevents;
CREATE TABLE ehr_schema.ingredientevents (	
   subject_id INT NOT NULL,	
   hadm_id INT NOT NULL,	
   stay_id INT NOT NULL,	
   caregiver_id INT,
   starttime DATETIME2 NOT NULL,
   endtime DATETIME2 NOT NULL,
   storetime DATETIME2 NOT NULL,
   itemid INT NOT NULL,	
   amount FLOAT NOT NULL,
   amountuom VARCHAR(255) NOT NULL,	
   rate FLOAT,
   rateuom VARCHAR(255),	
   orderid INT NOT NULL,	
   linkorderid INT NOT NULL,	
   statusdescription VARCHAR(255) NOT NULL,	
   originalamount BIT NOT NULL,	
   originalrate FLOAT NOT NULL,
)


DROP TABLE IF EXISTS ehr_schema.inputevents;
CREATE TABLE ehr_schema.inputevents
(                                                        
    subject_id                    INT          NOT NULL, 
    hadm_id                       INT          NOT NULL, 
    stay_id                       INT          NOT NULL, 
    caregiver_id                  INT,
    starttime                     DATETIME2    NOT NULL,
    endtime                       DATETIME2    NOT NULL,
    storetime                     DATETIME2    NOT NULL,
    itemid                        INT          NOT NULL, 
    amount                        FLOAT        NOT NULL,
    amountuom                     VARCHAR(255) NOT NULL, 
    rate                          FLOAT,
    rateuom                       VARCHAR(255),          
    orderid                       INT          NOT NULL, 
    linkorderid                   INT          NOT NULL, 
    ordercategoryname             VARCHAR(255) NOT NULL, 
    secondaryordercategoryname    VARCHAR(255),          
    ordercomponenttypedescription VARCHAR(255) NOT NULL, 
    ordercategorydescription      VARCHAR(255) NOT NULL, 
    patientweight                 FLOAT        NOT NULL,
    totalamount                   FLOAT,
    totalamountuom                VARCHAR(255),          
    isopenbag                     BIT          NOT NULL, 
    continueinnextdept            BIT          NOT NULL, 
    statusdescription             VARCHAR(255) NOT NULL, 
    originalamount                FLOAT        NOT NULL,
    originalrate                  FLOAT        NOT NULL,
)

DROP TABLE IF EXISTS ehr_schema.labevents;
CREATE TABLE ehr_schema.labevents (	
   labevent_id INT NOT NULL PRIMARY KEY,	
   subject_id INT NOT NULL,	
   hadm_id INT,	
   specimen_id INT NOT NULL,	
   itemid INT NOT NULL,	
   order_provider_id VARCHAR(255),
   charttime DATETIME2 NOT NULL,
   storetime DATETIME2,
   value varchar(168),	
   valuenum FLOAT,
   valueuom VARCHAR(255),	
   ref_range_lower FLOAT,
   ref_range_upper FLOAT,
   flag VARCHAR(255),	
   priority VARCHAR(255),	
   comments varchar(491)	
  )


DROP TABLE IF EXISTS ehr_schema.microbiologyevents;
CREATE TABLE ehr_schema.microbiologyevents (	
   microevent_id INT NOT NULL PRIMARY KEY,	
   subject_id INT NOT NULL,	
   hadm_id INT,	
   micro_specimen_id INT NOT NULL,	
   order_provider_id VARCHAR(255),
   chartdate DATETIME2 NOT NULL,
   charttime DATETIME2,
   spec_itemid INT NOT NULL,	
   spec_type_desc VARCHAR(255),	
   test_seq SMALLINT NOT NULL,	
   storedate DATETIME2,
   storetime DATETIME2,
   test_itemid INT NOT NULL,	
   test_name VARCHAR(255) NOT NULL,	
   org_itemid INT,	
   org_name VARCHAR(255),	
   isolate_num SMALLINT,	
   quantity VARCHAR(255),	
   ab_itemid INT,	
   ab_name VARCHAR(255),	
   dilution_text VARCHAR(255),	
   dilution_comparison VARCHAR(255),	
   dilution_value FLOAT,
   interpretation VARCHAR(255),	
   comments varchar(730)	
  )


DROP TABLE IF EXISTS ehr_schema.omr;
CREATE TABLE ehr_schema.omr (	
   subject_id INT NOT NULL,	
   chartdate DATE NOT NULL,
   seq_num SMALLINT NOT NULL,	
   result_name VARCHAR(255) NOT NULL,	
   result_value VARCHAR(255) NOT NULL	
  )


DROP TABLE IF EXISTS ehr_schema.outputevents;
CREATE TABLE ehr_schema.outputevents (	
   subject_id INT NOT NULL,	
   hadm_id INT NOT NULL,	
   stay_id INT NOT NULL,	
   caregiver_id INT,
   charttime DATETIME2 NOT NULL,
   storetime DATETIME2 NOT NULL,
   itemid INT NOT NULL,	
   value FLOAT NOT NULL,
   valueuom VARCHAR(255) NOT NULL	
  )


DROP TABLE IF EXISTS ehr_schema.pharmacy;
CREATE TABLE ehr_schema.pharmacy (	
   subject_id INT NOT NULL,	
   hadm_id INT NOT NULL,	
   pharmacy_id INT NOT NULL PRIMARY KEY,	
   poe_id VARCHAR(255),	
   starttime DATETIME2,
   stoptime DATETIME2,
   medication VARCHAR(255),	
   proc_type VARCHAR(255) NOT NULL,	
   status VARCHAR(255) NOT NULL,	
   entertime DATETIME2 NOT NULL,
   verifiedtime DATETIME2,
   route VARCHAR(255),	
   frequency VARCHAR(255),	
   disp_sched VARCHAR(255),	
   infusion_type VARCHAR(255),	
   sliding_scale VARCHAR(255),	
   lockout_interval VARCHAR(255),	
   basal_rate FLOAT,
   one_hr_max VARCHAR(255),	
   doses_per_24_hrs SMALLINT,	
   duration FLOAT,
   duration_interval VARCHAR(255),	
   expiration_value SMALLINT,	
   expiration_unit VARCHAR(255),	
   expirationdate DATETIME2,
   dispensation VARCHAR(255),	
   fill_quantity VARCHAR(255)	
  )

DROP TABLE IF EXISTS ehr_schema.poe;
CREATE TABLE ehr_schema.poe (	
   poe_id VARCHAR(255) NOT NULL PRIMARY KEY,	
   poe_seq SMALLINT NOT NULL,	
   subject_id INT NOT NULL,	
   hadm_id INT NOT NULL,	
   ordertime DATETIME2 NOT NULL,
   order_type VARCHAR(255) NOT NULL,	
   order_subtype VARCHAR(255),	
   transaction_type VARCHAR(255) NOT NULL,	
   discontinue_of_poe_id VARCHAR(255),	
   discontinued_by_poe_id VARCHAR(255),	
   order_provider_id VARCHAR(255),
   order_status VARCHAR(255) NOT NULL	

  )

DROP TABLE IF EXISTS ehr_schema.poe_detail;
CREATE TABLE ehr_schema.poe_detail (	
   poe_id VARCHAR(255) NOT NULL,	
   poe_seq SMALLINT NOT NULL,	
   subject_id INT NOT NULL,	
   field_name VARCHAR(255) NOT NULL,	
   field_value VARCHAR(255) NOT NULL,	
   PRIMARY KEY (poe_id,poe_seq,subject_id),
  )

DROP TABLE IF EXISTS ehr_schema.prescriptions;
CREATE TABLE ehr_schema.prescriptions
(                                            
    subject_id        INT          NOT NULL, 
    hadm_id           INT          NOT NULL, 
    pharmacy_id       INT          NOT NULL, 
    poe_id            VARCHAR(255),          
    poe_seq           SMALLINT,              
    order_provider_id VARCHAR(255),
    starttime         DATETIME2,
    stoptime          DATETIME2,
    drug_type         VARCHAR(255) NOT NULL, 
    drug              VARCHAR(255),          
    formulary_drug_cd VARCHAR(255),          
    gsn               varchar(223),          
    ndc               VARCHAR(255),          
    prod_strength     varchar(112),          
    form_rx           VARCHAR(255),          
    dose_val_rx       VARCHAR(255),          
    dose_unit_rx      VARCHAR(255),          
    form_val_disp     VARCHAR(255),          
    form_unit_disp    VARCHAR(255),          
    doses_per_24_hrs  SMALLINT,              
    route             VARCHAR(255),           
    PRIMARY KEY (subject_id, hadm_id, pharmacy_id, poe_id, poe_seq, order_provider_id)
)
DROP TABLE IF EXISTS ehr_schema.procedureevents;
CREATE TABLE ehr_schema.procedureevents (	
   subject_id INT NOT NULL,	
   hadm_id INT NOT NULL,	
   stay_id INT NOT NULL,	
   caregiver_id INT,
   starttime DATETIME2 NOT NULL,
   endtime DATETIME2 NOT NULL,
   storetime DATETIME2 NOT NULL,
   itemid INT NOT NULL,	
   value FLOAT NOT NULL,
   valueuom VARCHAR(255) NOT NULL,	
   location VARCHAR(255),	
   locationcategory VARCHAR(255),	
   orderid INT NOT NULL,	
   linkorderid INT NOT NULL,	
   ordercategoryname VARCHAR(255) NOT NULL,	
   ordercategorydescription VARCHAR(255) NOT NULL,	
   patientweight FLOAT NOT NULL,
   isopenbag BIT NOT NULL,	
   continueinnextdept BIT NOT NULL,	
   statusdescription VARCHAR(255) NOT NULL,	
   originalamount FLOAT NOT NULL,
   originalrate BIT NOT NULL,	
   PRIMARY KEY (subject_id, hadm_id, stay_id, itemid, starttime)
  )


DROP TABLE IF EXISTS ehr_schema.procedures_icd;
CREATE TABLE ehr_schema.procedures_icd (	
   subject_id INT NOT NULL,	
   hadm_id INT NOT NULL,	
   seq_num SMALLINT NOT NULL,	
   chartdate DATE NOT NULL,
   icd_code VARCHAR(255) NOT NULL,	
   icd_version SMALLINT NOT NULL,	
   PRIMARY KEY (subject_id, hadm_id, seq_num, icd_code)
  )

DROP TABLE IF EXISTS ehr_schema.provider;
CREATE TABLE ehr_schema.provider (	
   provider_id VARCHAR(255) NOT NULL PRIMARY KEY 
  )

DROP TABLE IF EXISTS ehr_schema.services;
CREATE TABLE ehr_schema.services (	
   subject_id INT NOT NULL,	
   hadm_id INT NOT NULL,	
   transfertime DATETIME2 NOT NULL,
   prev_service VARCHAR(255),	
   curr_service VARCHAR(255) NOT NULL,	
   PRIMARY KEY (subject_id, hadm_id, transfertime)
  )

DROP TABLE IF EXISTS ehr_schema.transfers;
CREATE TABLE ehr_schema.transfers (	
   subject_id INT NOT NULL,	
   hadm_id INT,	
   transfer_id INT NOT NULL PRIMARY KEY,	
   eventtype VARCHAR(255) NOT NULL,	
   careunit VARCHAR(255),	
   intime DATETIME2 NOT NULL,
   outtime DATETIME2,
)
