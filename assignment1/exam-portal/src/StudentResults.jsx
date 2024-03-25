import React, { useEffect, useState } from 'react';
import axios from 'axios';
import './StudentResults.css'; // Make sure your CSS file includes styles for the list

function StudentResults() {
    const [students, setStudents] = useState([]);
    const [selectedStudent, setSelectedStudent] = useState(null);
    const [exams, setExams] = useState([]);
    const [selectedExam, setSelectedExam] = useState(null);
    const [results, setResults] = useState([]);
    const [showModal, setShowModal] = useState(false);
    const [analytics, setAnalytics] = useState(null);

    useEffect(() => {
        fetchStudents();
    }, []);

    const fetchStudents = async () => {
        try {
            const response = await axios.get('http://localhost:3001/students');
            setStudents(response.data);
        } catch (error) {
            console.error('Error fetching students:', error);
        }
    };

    const handleStudentSelect = (studentId) => {
        setSelectedStudent(studentId);
        fetchExams(studentId);
    };

    const fetchExams = async (studentId) => {
        try {
            const response = await axios.get(`http://localhost:3001/exams-for-student?sid=${studentId}`);
            setExams(response.data);
            setResults([]); // Clear previous results
            setSelectedExam(null); // Reset exam selection
        } catch (error) {
            console.error('Error fetching exams for student:', error);
        }
    };

    const handleExamSelect = (examId) => {
        setSelectedExam(examId);
        fetchResults(selectedStudent, examId);
    };

    const fetchResults = async (studentId, examId) => {
        try {
            const response = await axios.get(`http://localhost:3001/student-results?sid=${studentId}&eid=${examId}`);
            setResults(response.data);
        } catch (error) {
            console.error('Error fetching results for exam:', error);
        }
    };

    const fetchAnalytics = async (studentId, examId) => {
        try {
            const response = await axios.get(`http://localhost:3001/exam-analytics?sid=${studentId}&eid=${examId}`);
            setAnalytics(response.data.data); // Assuming the backend sends data under a 'data' key
            setShowModal(true);
        } catch (error) {
            console.error('Error fetching analytics:', error);
        }
    };
    
    return (
        <>
        <div className="navbar">
        <a href="/evaldashboard">Home</a>
        {/* Additional navigation items here */}
      </div>
        <div className="student-results-container">
            <h1>Student Results</h1>
            <div className="form-columns">'
                <div className="left-column">
                    <div className="students-list">
                        {students.map((student) => (
                            <div key={student.id} 
                                className={`student-name ${selectedStudent === student.id ? 'selected' : ''}`}
                                onClick={() => handleStudentSelect(student.id)}>
                                {student.name}
                            </div>
                        ))}
                    </div>
                </div>
            <div className="middle-column">
                {selectedStudent && exams.length > 0 && (
                    <div className="exams-list">
                        {exams.map((exam) => (
                            <div key={exam.id}
                                className={`exam-name ${selectedExam === exam.id ? 'selected' : ''}`}
                                onClick={() => handleExamSelect(exam.id)}>
                                {exam.name} ({exam.date})
                            </div>
                        ))}
                    </div>
                )}

                {showModal && analytics && (
                <div className="modal">
                    <div className="modal-content">
                        <span className="close" onClick={() => setShowModal(false)}>&times;</span>
                        <h2>Analytics for Exam {selectedExam}:</h2>
                        {/* Display analytics data here */}
                        <p>Total Questions: {analytics.total_questions}</p>
                        <p>Correct Answers: {analytics.correct_answers}</p>
                        <p>Average Time Taken: {analytics.average_time_taken}</p>
                        <p>Average Difficulty: {analytics.average_difficulty}</p>
                        </div>
                    </div>
                )}
            </div>

            <div className="right-column">
                {selectedExam && results.length > 0 && (
                    <>
                    <div className="exam-results">
                    <h2>Results for Exam {selectedExam}:</h2>
                    <table>
                        <thead>
                        <tr>
                            <th>QID</th>
                            <th>Question Content</th>
                            <th>Correct Option ID</th>
                            <th>Student's Response</th>
                        </tr>
                        </thead>
                        <tbody>
                        {results.map((result, index) => (
                            <tr key={index}>
                            <td>{result.qid}</td>
                            <td>{result.qcontent}</td>
                            <td>{result.correct_option_id}</td>
                            <td>{JSON.parse(result.response).useroption}</td>
                            </tr>
                        ))}
                        </tbody>
                    </table>
                    </div>
                    <button onClick={() => fetchAnalytics(selectedStudent, selectedExam)}>Show Analytics</button>

                    </>
                    
                )}
                </div>
                

            </div>
        
        </div>
        </>
        
    );
}

export default StudentResults;
