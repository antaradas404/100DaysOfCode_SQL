# Write your MySQL query statement below

# Write an SQL query to report the IDs of the missing subtasks for each task_id.

# Recursive CTE
WITH RECURSIVE SubtasksCTE AS (
  SELECT
    task_id,
    1 AS subtask_id,
    subtasks_count
  FROM Tasks
 
  UNION ALL

  SELECT
    task_id,
    subtask_id + 1,
    subtasks_count
  FROM SubtasksCTE
  WHERE subtask_id < subtasks_count
)

SELECT s.task_id, s.subtask_id
FROM SubtasksCTE s
LEFT JOIN Executed e ON s.task_id = e.task_id AND s.subtask_id = e.subtask_id
WHERE e.task_id IS NULL
ORDER BY s.task_id, s.subtask_id;