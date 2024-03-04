import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import LoginPage from './LoginPage';
import RegistrationPage from './RegistrationPage';
import HomePage from './HomePage';
import ExamRegister from './ExamRegister';
import StudentSchedule from './StudentSchedule';
import ExamPage from './ExamPage';


function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<LoginPage />} />
        <Route path="/register" element={<RegistrationPage />} />
        <Route path="/homepage" element={<HomePage />} />

        <Route path="/login" element={<LoginPage />} />
        <Route path="/register2" element={<RegistrationPage />} />
        <Route path="/exam-register" element={<ExamRegister />} />
        <Route path="/register-for-exam" element={<ExamRegister />} />
        <Route path="/stud-schedule" element={<StudentSchedule />} />
        <Route path="/start-exam" element={<ExamPage />} />
      </Routes>
    </Router>
  );
}

export default App;
