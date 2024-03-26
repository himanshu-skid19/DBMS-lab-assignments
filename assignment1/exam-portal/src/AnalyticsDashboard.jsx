import React, { useState, useEffect } from 'react';
import axios from 'axios';
import BarChart from './BarChart';
import ScatterPlot from './ScatterPlot';
import './AnalyticsDashboard.css';

function AnalyticsDashboard() {
    const [analyticsData, setAnalyticsData] = useState([]);
    const [selectedExam, setSelectedExam] = useState('');
    const [isLoading, setIsLoading] = useState(true);

    useEffect(() => {
        fetchAnalytics();
    }, []);

    const fetchAnalytics = async () => {
        setIsLoading(true);
        try {
            const response = await axios.get('http://localhost:3001/analytics', { withCredentials: true });
            if (response.data.status === 'success') {
                setAnalyticsData(response.data.data);
                setIsLoading(false);
            } else {
                console.error('Failed to fetch analytics');
                setIsLoading(false);
            }
        } catch (error) {
            console.error('Error fetching analytics data:', error);
            setIsLoading(false);
        }
    };

    const handleExamSelection = (event) => {
        setSelectedExam(event.target.value);
    };

      // Calculate overall analytics directly from analyticsData
      const overallAnalytics = analyticsData.reduce((acc, exam) => {
        acc.totalQuestions += Number(exam.total_questions);
        acc.correctAnswers += Number(exam.correct_answers);
        acc.averageTimeTaken += Number(exam.average_time_taken);
        acc.averageDifficulty += Number(exam.average_difficulty);
          return acc;
      }, {
          totalQuestions: 0,
          correctAnswers: 0,
          averageTimeTaken: 0,
          averageDifficulty: 0,
      });

      // Adjust calculations if you're aggregating data
      if (overallAnalytics.totalQuestions > 0) {
          overallAnalytics.averageTimeTaken /= analyticsData.length;
          overallAnalytics.averageDifficulty /= analyticsData.length;
      }

    if (isLoading) {
        return <div>Loading...</div>;
    }

    const selectedExamData = analyticsData.find(exam => `${exam.eid}|${exam.did}` === selectedExam);

    return (
        <>
            <div className="navbar">
                <a href="/homepage">Home</a>
            </div>
            <div className="analytics-dashboard">
                <div className="analytics-container">
                    <h2>Exam Analytics Dashboard</h2>
                    <div className="analytics-dropdown">
                        <label>Select an exam to view detailed analytics:</label>
                        <select value={selectedExam} style={{ color: 'black' }} onChange={handleExamSelection}>
                            <option value="">Overall Analytics</option>
                            {analyticsData.map(({ eid, did, exam_name }) => (
                                <option key={`${eid}|${did}`} value={`${eid}|${did}`}>{exam_name}</option>
                            ))}
                        </select>
                    </div>
                    {selectedExam === '' ? (
                        <div>
                            <h2>Overall Analytics</h2>
                            <div className="combined-analytics">
                                <p>Total Questions: {overallAnalytics.totalQuestions}</p>
                                <p>Correct Answers: {overallAnalytics.correctAnswers}</p>
                                <p>Average Time Taken: {overallAnalytics.averageTimeTaken.toFixed(2)}s</p>
                                <p>Average Difficulty: {overallAnalytics.averageDifficulty.toFixed(2)}</p>
                            </div>
                        </div>
                    ) : (
                        selectedExamData && (
                            <div>
                                <h2>Analytics for Selected Exam</h2>
                                <div className="exam-analytics">
                                    <h3>{selectedExamData.exam_name}</h3>
                                    <p>Total Questions: {selectedExamData.total_questions}</p>
                                    <p>Correct Answers: {selectedExamData.correct_answers}</p>
                                    <p>Average Time Taken: {selectedExamData.average_time_taken}s</p>
                                    <p>Average Difficulty: {selectedExamData.average_difficulty}</p>
                                </div>
                            </div>
                        )
                    )}
                </div>
                <div className="graphs-container">
                    {selectedExam === '' ? (
                        <>
                            <BarChart data={analyticsData} />
                            <ScatterPlot data={analyticsData} />
                        </>
                    ) : (
                        selectedExamData && (
                            <>
                                {/* Customize these components to use selectedExamData */}
                                <BarChart data={[selectedExamData]} />
                                <ScatterPlot data={[selectedExamData]} />
                            </>
                        )
                    )}
                </div>
            </div>
        </>
    );
}

export default AnalyticsDashboard;
