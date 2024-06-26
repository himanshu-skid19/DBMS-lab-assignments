import { useState, useEffect } from 'react';
import './ExamRegister.css';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';

function ExamRegister() {
  const [exams, setExams] = useState([]);
  const [selectedExam, setSelectedExam] = useState(null);
  const [error, setError] = useState('');
  const [successMessage, setSuccessMessage] = useState(''); // State to store success message
  axios.defaults.withCredentials = true;
  const navigate = useNavigate(); // Hook for navigation

  useEffect(() => {
    axios.post('http://localhost:3001/exam-register', { withCredentials: true })
      .then(response => {
        if (response.data.status === 'success') {
          setExams(response.data.data);
        } else {
          setError('Failed to fetch exams: ' + response.data.message);
        }
      })
      .catch(error => {
        console.error('There was an error fetching the exams!', error);
        setError('There was an error fetching the exams: ' + error.message);
      });
  }, []);

  const RegisterForExam = () => {
    if (selectedExam) {
      axios.post('http://localhost:3001/register-for-exam', { did: selectedExam }, { withCredentials: true })
      .then(response => {
        // Handle success response
        if(response.data.status === 'success') {
          setSuccessMessage(response.data.message || 'Registration successful!');
          setError(''); // Clear any previous errors
        } else {
          // Handle case where user tries to register for an exam they're already registered for
          setError(response.data.message || 'Error registering for the exam.');
          setSuccessMessage(''); // Clear any previous success messages
        }
      })
      .catch(error => {
        console.error('There was an error registering for the exam!', error);
        setError('There was an error registering for the exam: ' + error.message);
        setSuccessMessage(''); // Clear any previous success messages
      });
    }
  };

  return (
    <>
      <div className="navbar">
        <a href="/homepage">Home</a>
        {/* Additional navigation items here */}
      </div>
      <div className="registration-page">
        <h1>Exam Registration</h1>
        {error && <p className="error">{error}</p>}
        {successMessage && <p className="success">{successMessage}</p>}
        <div className="exam-list-container">
          {exams.length > 0 ? exams.map(exam => (
            <div key={exam.eid} className="exam-entry">
              <div className="exam-info">
                <h2>{exam.ename}</h2>
                <p>Date: {exam.Date}</p>
                <p>Slot: {exam.Timeslot}</p>
                <p>Fees: {exam.fees}</p>
              </div>
              <div>
                <button className="exam-select-button" onClick={() => setSelectedExam(exam.did)}>
                    {selectedExam === exam.did ? 'Selected' : 'Select'}
                </button>
              </div>
            </div>
          )) : <p>No exams available to register for at this time.</p>}
        </div>
        {selectedExam && (
          <div>
            <h2>You have selected exam ID {selectedExam}. Ready to register?</h2>
            <button onClick={RegisterForExam}>Register</button>
          </div>
        )}
      </div>
    </>
  );
};

export default ExamRegister;
