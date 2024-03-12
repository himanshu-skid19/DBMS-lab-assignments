// AnalyticsDashboard.jsx
import React, { useState, useEffect } from 'react';
import axios from 'axios';
import BarChart from './BarChart';
import ScatterPlot from './ScatterPlot';
import './AnalyticsDashboard.css';


function AnalyticsDashboard() {
    const [analyticsData, setAnalyticsData] = useState([]);
    const [selectedExam, setSelectedExam] = useState('');
    const [selectedDateId, setSelectedDateId] = useState('');
    const [overallAnalytics, setOverallAnalytics] = useState({
        totalQuestions: 0,
        correctAnswers: 0,
        averageTimeTaken: 0,
        averageDifficulty: 0,
    });

    useEffect(() => {
        fetchAnalytics();
    }, []);

    useEffect(() => {
        if (analyticsData.length) {
            const combined = analyticsData.reduce(
                (acc, exam) => {
                    acc.totalQuestions += Number(exam.total_questions);
                    acc.correctAnswers += Number(exam.correct_answers);
                    acc.averageTimeTaken += Number(exam.average_time_taken);
                    acc.averageDifficulty += Number(exam.average_difficulty);
                    return acc;
                },
                {
                    totalQuestions: 0,
                    correctAnswers: 0,
                    averageTimeTaken: 0,
                    averageDifficulty: 0,
                }
            );
            combined.averageTimeTaken /= analyticsData.length*1000
            combined.averageDifficulty /= analyticsData.length;
            setOverallAnalytics(combined);
        }
    }, [analyticsData]);

    const fetchAnalytics = async () => {
        try {
            const response = await axios.get('http://localhost:3001/analytics', { withCredentials: true });
            if (response.data.status === 'success') {
                setAnalyticsData(response.data.data);
            } else {
                console.error('Failed to fetch analytics');
            }
        } catch (error) {
            console.error('There was an error fetching analytics data', error);
        }
    };

    const handleExamSelection = (event) => {
      const value = event.target.value;
      const [eid, did] = value.split('|');
      setSelectedExam(eid);
      setSelectedDateId(did);
    };

    return (
        <>
          <div className="navbar">
            <a href="/homepage">Home</a>
            {/* Other navbar items */}
          </div>
          <div className="analytics-dashboard">
            <div className="analytics-container">
              <h2>Exam Analytics Dashboard</h2>
              <div className="analytics-dropdown">
                <label>Select an exam to view detailed analytics:</label>
                <select value={`${selectedExam}|${selectedDateId}`} onChange={handleExamSelection}>
                  <option value="">All Exams</option>
                  {analyticsData.map(({ eid, did, exam_name }) => (
                    <option key={`${eid}|${did}`} value={`${eid}|${did}`}>{exam_name}</option>
                  ))}
                </select>
              </div>
              <div className="overall-analytics">
                {/* Display overall analytics or specific exam analytics based on selection */}
                {selectedExam === '' ? (
                  <div>
                    <h2>Overall Analytics</h2>
                    <div className="combined-analytics">
                        <p>Total Questions: {overallAnalytics.totalQuestions}</p>
                        <p>Correct Answers: {overallAnalytics.correctAnswers}</p>
                        <p>Average Time Taken: {overallAnalytics.averageTimeTaken}s</p>
                        <p>Average Difficulty: {overallAnalytics.averageDifficulty}</p>
                    </div>
                  </div>
                ) : (
                  <div>
                    <h2> Analytics for Selected Exam</h2>
                    {analyticsData.filter(exam => exam.eid === selectedExam).map(exam => (
                        <div key={'${eid}|${did}'} className="exam-analytics">
                            <h3> {exam.exam_name}</h3>
                            <h3> Date: {exam.did}</h3>
                            <p>Total Questions: {exam.total_questions}</p>
                            <p>Correct Answers: {exam.correct_answers}</p>
                            <p>Average Time Taken: {exam.average_time_taken}s</p>
                            <p>Average Difficulty: {exam.average_difficulty}</p>
                            </div>
                    ))}
                  </div>
                )}
              </div>
            </div>
            {selectedExam === '' && (
                <div className="graphs-container">
                    <div className="graph-container">
                    <BarChart data={analyticsData} />
                    </div>
                    <div className="graph-container">
                    <ScatterPlot data={analyticsData} />
                    </div>
                    {/* Add two more graph containers here */}
                    <div className="graph-container">
                    {/* Another graph component */}
                    </div>
                    <div className="graph-container">
                    {/* Another graph component */}
                    </div>
                </div>
                )}
          </div>
        </>
      );
    }
    

export default AnalyticsDashboard;