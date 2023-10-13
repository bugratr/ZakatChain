// Assuming you are using jQuery for AJAX operations

// Endpoint to get the list of applicants
const APPLICANTS_ENDPOINT = "getApplicants.php";

$(document).ready(function() {
    fetchApplicants();
});

function fetchApplicants() {
    $.ajax({
        url: APPLICANTS_ENDPOINT,
        method: 'GET',
        dataType: 'json',
        success: function(data) {
            populateApplicants(data);
        },
        error: function(error) {
            console.error("Error fetching applicants:", error);
        }
    });
}

function populateApplicants(applicants) {
    let tbody = $("#applicantsList");
    tbody.empty(); // Clear any previous entries

    applicants.forEach(applicant => {
        let row = `<tr>
            <td>${applicant.id}</td>
            <td>${applicant.name}</td>
            <td>${applicant.idNumber}</td>
            <td>${applicant.email}</td>
            <td>${applicant.phone}</td>
            <td><a href="${applicant.documentURL}" target="_blank">View Document</a></td>
        </tr>`;

        tbody.append(row);
    });
}
