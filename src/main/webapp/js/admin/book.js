function openModal(){
    const modalContainer = document.getElementById("modal");
    modalContainer.classList.remove("hidden");
}
function closeModal(){
    const modalContainer = document.getElementById("modal");
    modalContainer.classList.add("hidden");
}

function openEditModal(bookID){
    const editModal = document.getElementById("editModal"+bookID)
    editModal.classList.remove("hidden")
}

function closeEditModal(bookID){
    const editModal = document.getElementById("editModal"+bookID)
    editModal.classList.add("hidden")
}

function bookAddedToast() {
    Toastify({
        text: "Book added successfully",
        duration: 3000, // 3 seconds
        close: true,
        gravity: "top", // toast position
        position: "center", // toast position
        stopOnFocus: true // Prevents dismissing the toast on focus
    }).showToast();
}

function bookDeletedToast() {
    Toastify({
        text: "Book Deleted successfully",
        duration: 3000, // 3 seconds
        close: true,
        gravity: "top", // toast position
        position: "center", // toast position
        stopOnFocus: true // Prevents dismissing the toast on focus
    }).showToast();
}
