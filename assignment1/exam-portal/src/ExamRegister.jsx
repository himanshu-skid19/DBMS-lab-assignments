import { useState, useEffect } from 'react';
import './ExamRegister.css';
import axios from 'axios';

function ExamRegister() {
  const [exams, setExams] = useState([]);
  const [selectedExam, setSelectedExam] = useState(null);
  const [error, setError] = useState('');
  axios.defaults.withCredentials = true;

  useEffect(() => {
    axios.post('http://localhost:3001/exam-register', { withCredentials: true })
      .then(response => {
        // Check the structure of the response here
        // console.log('Exams fetched:', response.data);
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
          console.log(response.data.message);
        })
        .catch(error => {
          console.error('There was an error registering for the exam!', error);
        });
    }
  };

  return (<>
    <div className="navbar">
          <a href="/homepage">Home</a>
          {/* Additional navigation items here */}
      </div>
    <div className="registration-page">
      <h1>Exam Registration</h1>
      {error && <p className="error">{error}</p>}
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
    
)};

export default ExamRegister;