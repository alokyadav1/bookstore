<div class="flex justify-center items-center h-screen relative overlay">
    <div class="bg-white p-8 rounded-lg shadow-md max-w-md w-full relative" id="form-container">
        <h1 class="text-3xl font-semibold mb-6 text-center">Add New Book</h1>
        <form action="${pageContext.request.contextPath}/book" method="POST" class="space-y-4">
            <div>
                <label for="title" class="block text-sm font-medium text-gray-700">Title:</label>
                <input type="text" id="title" name="title"
                       class="mt-1 focus:ring-blue-500 focus:border-blue-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md px-4 py-2">
            </div>
            <div>
                <label for="description" class="block text-sm font-medium text-gray-700">Description:</label>
                <textarea id="description" name="description" rows="3"
                          class="mt-1 focus:ring-blue-500 focus:border-blue-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md px-4 py-2"></textarea>
            </div>
            <div>
                <label for="author" class="block text-sm font-medium text-gray-700">Author:</label>
                <input type="text" id="author" name="author"
                       class="mt-1 focus:ring-blue-500 focus:border-blue-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md px-4 py-2">
            </div>
            <div>
                <label for="isbn" class="block text-sm font-medium text-gray-700">ISBN:</label>
                <input type="text" id="isbn" name="isbn"
                       class="mt-1 focus:ring-blue-500 focus:border-blue-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md px-4 py-2">
            </div>
            <div>
                <label for="rating" class="block text-sm font-medium text-gray-700">Rating:</label>
                <input type="number" id="rating" name="rating" min="1" max="5"
                       class="mt-1 focus:ring-blue-500 focus:border-blue-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md px-4 py-2">
            </div>
            <div>
                <label for="price" class="block text-sm font-medium text-gray-700">Price:</label>
                <input type="number" id="price" name="price" min="0" step="0.01"
                       class="mt-1 focus:ring-blue-500 focus:border-blue-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md px-4 py-2">
            </div>
            <div class="flex justify-between gap-2">
                <button type="submit"
                        class="w-full bg-blue-500 text-white py-2 px-4 rounded-md hover:bg-blue-600 focus:outline-none focus:bg-blue-600 transition duration-300">
                    Add Book
                </button>
                <button type="button"
                        class="w-full bg-red-500 text-white py-2 px-4 rounded-md hover:bg-red-600 focus:outline-none focus:bg-red-600 transition duration-300 cursor-pointer"
                        onclick="closeModal()">Close
                </button>
            </div>
        </form>
        <div class="absolute top-5 right-5">
            <span onclick="closeModal()">Close</span>
        </div>
    </div>
</div>

