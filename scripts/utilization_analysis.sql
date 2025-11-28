--Utilization patterns and clinical activity analysis
--Encounter volumn trend
SELECT
    YEAR(EffectiveDate) AS Year,
    EncounterClass,
    Encounter_Text,
    COUNT(*) AS NumEncounters
FROM gold.fact_observation_encounter
WHERE EffectiveDate >= '2011-01-01'
GROUP BY YEAR(EffectiveDate), EncounterClass, encounter_text
ORDER BY Year, NumEncounters DESC;

--Observation Type Distribution & Clinical Activity Mix
SELECT
    ObservationCategory,
    ObservationCode,
    ObservationText,
    COUNT(*) AS NumObservations
FROM gold.fact_observation_encounter
WHERE EffectiveDate >= '2011-01-01'
GROUP BY ObservationCategory, ObservationCode, ObservationText
ORDER BY NumObservations DESC;

--High-Utilization Patients" Observation burden
SELECT
    o.PatientID,
    p.Gender,
    p.BirthDate,
    COUNT(*) AS NumObservations
FROM gold.fact_observation_encounter o
JOIN gold.dim_patient p ON o.PatientID = p.PatientID
WHERE EffectiveDate >= '2011-01-01'
GROUP BY o.PatientID, p.Gender, p.BirthDate
ORDER BY NumObservations DESC;

--Provider Utilization: Workload and efficiency index
SELECT
    e.PractitionerName,
    COUNT(*) AS NumEncounters,
    COUNT(DISTINCT e.PatientID) AS NumUniquePatients
FROM gold.fact_observation_encounter e
WHERE EffectiveDate >= '2011-01-01'
GROUP BY e.PractitionerName
ORDER BY NumEncounters DESC;

--service provider utilization
SELECT
    e.ServiceProvider,
    COUNT(*) AS NumEncounters,
    COUNT(DISTINCT e.PatientID) AS NumPatients
FROM gold.fact_observation_encounter e
WHERE EffectiveDate >= '2011-01-01'
GROUP BY e.ServiceProvider
ORDER BY NumEncounters DESC;
