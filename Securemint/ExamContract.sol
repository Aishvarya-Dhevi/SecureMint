// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ExamContract {
    struct Exam {
        string examName;
        uint256 startTime;
        uint256 endTime;
        uint256 duration;
        uint256 totalMarks;
        uint256 totalQuestions;
        address createdBy;
    }

    mapping(uint256 => Exam) public exams;
    uint256 public examCount;
    address public owner;

    event ExamCreated(
        uint256 indexed examId,
        string examName,
        uint256 startTime,
        uint256 endTime,
        uint256 duration,
        uint256 totalMarks,
        uint256 totalQuestions,
        address createdBy
    );

    constructor() {
        owner = msg.sender;
    }

    function createExam(
        string memory _examName,
        uint256 _startTime,
        uint256 _endTime,
        uint256 _duration,
        uint256 _totalMarks,
        uint256 _totalQuestions
    ) public {
        require(_startTime < _endTime, "Start time must be before end time");
        require(_duration > 0, "Duration must be greater than 0");

        examCount++;
        exams[examCount] = Exam({
            examName: _examName,
            startTime: _startTime,
            endTime: _endTime,
            duration: _duration,
            totalMarks: _totalMarks,
            totalQuestions: _totalQuestions,
            createdBy: msg.sender
        });

        emit ExamCreated(
            examCount,
            _examName,
            _startTime,
            _endTime,
            _duration,
            _totalMarks,
            _totalQuestions,
            msg.sender
        );
    }

    function getExam(uint256 _examId) public view returns (
        string memory,
        uint256,
        uint256,
        uint256,
        uint256,
        uint256,
        address
    ) {
        require(_examId > 0 && _examId <= examCount, "Invalid Exam ID");
        Exam memory exam = exams[_examId];
        return (
            exam.examName,
            exam.startTime,
            exam.endTime,
            exam.duration,
            exam.totalMarks,
            exam.totalQuestions,
            exam.createdBy
        );
    }
}
