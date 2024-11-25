import { useState, useEffect } from "react";
import WhatIfAnalysisForm from "./WhatIfAnalysisForm";
import StudentIDSearch from "../StudentIDSearch";

const WhatIf = () => {
  const userRole = sessionStorage.getItem("userRole");
  const userID = sessionStorage.getItem("studentId"); 

  const [studentID, setStudentID] = useState<string | null>(null);

  useEffect(() => {
    console.log("What if UserRole:", userRole); // Debug statement
    console.log("What if UserID:", userID); // Debug statement

    // If userRole is "student", set studentID to userID
    if (userRole === "Student" && userID) {
      console.log("Setting studentID to userID:", userID); // Debug statement
      setStudentID(userID);
    }
  }, [userRole, userID]);

  /**
   * Searches database for student associated with id value
   * @param id The ID to search for
   */
  const handleIDSearch = (id: string) => {
    console.log("handleIDSearch called with ID:", id); // Debug statement
    setStudentID(id); // Sets the student ID from the search
  };

  console.log("Current studentID:", studentID); // Debug statement

  return (
    <>
      <div className="display-6">What-If Analysis</div>
      <hr />

      {studentID ? (
        // If the studentId is set, show that student's what-if form
        <WhatIfAnalysisForm studentID={studentID} />
      ) : (
        // Otherwise, if the user is an advisor or ID is not set, show a studentId entry form
        <StudentIDSearch onSearch={handleIDSearch} />
      )}
    </>
  );
};

export default WhatIf;