import { useState, useEffect } from 'react';
import './ExamRegister.css';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';

function StudentSchedule() {
  const [exams, setExams] = useState([]);
  const [selectedExam, setSelectedExam] = useState(null);
  const [selectedDate, setSelectedDate] = useState(null);
  const [error, setError] = useState('');
  const [successMessage, setSuccessMessage] = useState(''); // State to store success message
  axios.defaults.withCredentials = true;
  const navigate = useNavigate(); // Hook for navigation

  const handleSelectExam = (exam) => {
    setSelectedExam(exam.eid);
    setSelectedDate(exam.did);

  };

  useEffect(() => {
    axios.post('http://localhost:3001/stud-schedule', { withCredentials: true })
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

  const StartExam = () => {
    if (selectedExam) {
      axios.post('http://localhost:3001/start-exam', { did: selectedDate, eid: selectedExam }, { withCredentials: true })
      .then(response => {
        // Handle success response
        if(response.data.status === 'success') {
            navigate('/start-exam', {state: {eid : selectedExam, did: selectedDate}}); // Redirect to exam page
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
        <h1>Exam Schedule</h1>
        {error && <p className="error">{error}</p>}
        {successMessage && <p className="success">{successMessage}</p>}
        <div className="exam-list-container">
          {exams.length > 0 ? exams.map(exam => (
            <div key={exam.eid} className="exam-entry">
              <div className="exam-info">
                <h2>{exam.ename}</h2>
                <p>Date: {exam.Date}</p>
                <p>Slot: {exam.Timeslot}</p>
              </div>
              <div>
                <button className="exam-select-button" onClick={() => handleSelectExam(exam)}>
                    {selectedExam === exam.eid ? 'Selected' : 'Select'}
                </button>
              </div>
            </div>
          )) : <p>You haven't registered for any exams yet.</p>}
        </div>
        {selectedExam && (
          <div>
            <h2>You have selected exam ID {selectedExam}. Ready to Start?</h2>
            <button onClick={StartExam}>Start Exam</button>
          </div>
        )}
      </div>
    </>
  );
};

export default StudentSchedule;
