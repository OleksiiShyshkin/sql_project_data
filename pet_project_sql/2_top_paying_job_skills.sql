/*
Question: What are the top-paying data analyst jobs, and what skills are required?
- Identify the top 10 highest-paying Data Analyst jobs and the specific skills required for these roles.
- Filters for roles with specified salaries that are remote
- Why? It provides a detailed look at which high-paying jobs demand certain skills, helping job seekers understand which skills to develop that align with top salaries
*/

WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        cd.name AS company,
        salary_year_avg
    FROM
        job_postings_fact AS jpf
        LEFT JOIN company_dim AS cd
            ON jpf.company_id = cd.company_id  
    WHERE
        job_title_short = 'Data Analyst'
        AND job_location = 'Anywhere'
        AND salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT
        10
)

SELECT
    sd.skills,
    COUNT(sd.skills)
FROM
    skills_job_dim AS sjd
    JOIN skills_dim AS sd
        ON sjd.skill_id = sd.skill_id
    RIGHT JOIN top_paying_jobs AS tpj
        ON tpj.job_id = sjd.job_id
GROUP BY
    sd.skills
ORDER BY
    COUNT(sd.skills) DESC
LIMIT 10;