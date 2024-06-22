USE ehr;

-- 1. Jedinstveni indeks na subject_id u tabeli patients
CREATE UNIQUE INDEX idx_patients_subject_id ON ehr_schema.patients (subject_id);

-- 2. Jedinstveni kompozitni indeks na subject_id i hadm_id u tabeli admissions
CREATE UNIQUE INDEX idx_admissions_subject_hadm_id ON ehr_schema.admissions (subject_id, hadm_id);

-- 3. Kompozitni indeks na subject_id i charttime u tabeli chartevents
CREATE INDEX idx_chartevents_subject_charttime ON ehr_schema.chartevents (subject_id, charttime);

-- 4. Indeks na itemid u tabeli d_items
CREATE INDEX idx_d_items_itemid ON ehr_schema.d_items (itemid);

-- 5. Indeks na icd_code u tabeli diagnoses_icd
CREATE INDEX idx_diagnoses_icd_icd_code ON ehr_schema.diagnoses_icd (icd_code);
