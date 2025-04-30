$(document).ready(function () {
    const isSupervisor = currentUserType === 'S';

    const mode = $('#attendanceMode').val(); // 'TimeBased' or 'JobBased'
    const isTimeBased = mode === 'TimeBased';

    let gridData = [];

    function makeEditable(type) {
        return isSupervisor ? { editable: { type } } : {};
    }

    let columns = [
        { field: 'rosterId', text: 'Roster ID', size: '100px', ...makeEditable('text')},
        { field: 'attendanceDate', text: 'Attendance Date', size: '120px', ...makeEditable('date'), render: 'date', style: 'text-align: right' }
    ];

    if (isTimeBased) {
        columns = columns.concat([
            { field: 'startTime', text: 'Start Time', size: '100px', ...makeEditable('time'), render: 'time', style: 'text-align: right' },
            { field: 'endTime', text: 'End Time', size: '100px', ...makeEditable('time'), render: 'time', style: 'text-align: right' },
            { field: 'totalHours', text: 'Total Hours', size: '100px', render: 'int' },
            { field: 'breakTime', text: 'Break Time', size: '100px', ...makeEditable('float'), render: 'int' }
        ]);
    } else {
        columns = columns.concat([
            { field: 'jobId', text: 'Job ID', size: '100px', ...makeEditable('int') },
            { field: 'jobName', text: 'Job Name', size: '150px' },
            { field: 'quantity', text: 'Quantity', size: '100px', ...makeEditable('float') },
            { field: 'rate', text: 'Rate', size: '100px', ...makeEditable('float') },
            { field: 'amount', text: 'Amount', size: '100px', render: 'money' }
        ]);
    }

    columns = columns.concat([
        { field: 'pay', text: 'Pay', size: '100px', ...makeEditable('money'), render: 'money' },
        {
            field: 'attendanceSignPic', text: 'Sign Pic', size: '180px',
            render(record) {
                const hasPic = record.attendanceSignPic && record.attendanceSignPic !== '';
                return ` 
                    <button class="editBtn" ${!isSupervisor ? 'disabled' : ''}>Edit</button>
                    <button class="viewBtn" ${hasPic ? '' : 'disabled'}>View</button>
                `;
            }
        },
        { field: 'blockId', text: 'Block ID', size: '100px', ...makeEditable('int') },
        { field: 'lineId', text: 'Line ID', size: '100px', ...makeEditable('int') },
        { field: 'jobPaid', text: 'Job Paid', size: '100px', ...makeEditable('checkbox') },
        { field: 'remarks', text: 'Remarks', size: '200px', ...makeEditable('text') },
        { field: 'appliedBy', text: 'Applied By', size: '120px' },
        { field: 'approvedStatus', text: 'Approved Status', size: '120px' },
        { field: 'approvedBy', text: 'Approved By', size: '120px' },
        { field: 'approvedDt', text: 'Approved Date', size: '120px', render: 'date', style: 'text-align: right' }
    ]);

    let grid = new w2grid({
        name: 'grid',
        box: '#grid',
        show: {
            toolbar: true,
            footer: true,
            toolbarDelete: false,
            toolbarSearch: false
        },
        columns,
        onRefresh: function (event) {
            // Apply 'deleted-row' class if _isDeleted is true for any row
            this.records.forEach(record => {
                if (record._isDeleted) {
                    // Add 'deleted-row' class to the row
                    $(this.get(record.recid)).addClass('deleted-row');
                } else {
                    // Ensure non-deleted rows do not have the class
                    $(this.get(record.recid)).removeClass('deleted-row');
                }
            });
        },
        records: [],
        toolbar: {
            items: isSupervisor ? [
                { id: 'add', type: 'button', text: 'Add Record', icon: 'w2ui-icon-plus' },
                { id: 'save', type: 'button', text: 'Save', icon: 'w2ui-icon-save' },
                { id: 'delete', type: 'button', text: 'Delete', icon: 'w2ui-icon-delete' }
            ] : [],
            onClick(event) {
                if (event.target === 'add') {
                    // Add new record and mark it as _isNew
                    let recid = grid.records.length + 1;
                    grid.add({
                        recid,
                        _isNew: true, // Mark as new
                        rosterId: '',
                        attendanceDate: '',
                        startTime: '',
                        endTime: '',
                        totalHours: '',
                        breakTime: '',
                        jobId: '',
                        jobName: '',
                        quantity: '',
                        rate: '',
                        amount: '',
                        pay: '',
                        attendanceSignPic: '',
                        blockId: '',
                        lineId: '',
                        jobPaid: false,
                        remarks: '',
                        appliedBy: currentUserId,
                        approvedStatus: 'P',
                        approvedBy: '',
                        approvedDt: ''
                    });
                    grid.scrollIntoView(recid);
                    grid.editField(recid, 1);  // Start editing the first field
                }
                if (event.target === 'save') {
                    saveRecords();
                }
                if (event.target === 'delete') {
                    deleteSelectedRows();
                }
            }
        },
        afterEditDone(index, column, event) {
            const record = grid.records[index];
            if (isTimeBased && ['startTime', 'endTime', 'breakTime'].includes(grid.columns[column].field)) {
                calculateTotalHours(record);
            }
        }
    });
    // Function to delete selected rows and mark them with _isDeleted
    function deleteSelectedRows() {
        const selectedRows = grid.getSelection(); // Get selected rows
        console.log("Selected Rows: ", selectedRows);  // Debug log

        if (selectedRows.length === 0) {
            alert("No rows selected for deletion.");
            return;
        }

        selectedRows.forEach(recid => {
            const record = grid.get(recid);
            console.log("Record to be deleted: ", record); // Log record

            if (record._isNew) {
                // If the row is newly added, just remove it directly
                grid.remove(recid);
                console.log(`Row ${recid} removed from grid (new record)`);
            } else {
                // Otherwise, mark it as deleted
                record._isDeleted = true;
                grid.refreshRow(recid);  // Refresh the row to show that it's deleted
                console.log(`Row ${recid} marked as deleted`);
            }
        });
    }

    function calculateTotalHours(record) {
        const changes = record.w2ui?.changes || {};
        const startTimeStr = changes.startTime ?? record.startTime;
        const endTimeStr = changes.endTime ?? record.endTime;
        let breakTime = changes.breakTime ?? record.breakTime;

        const startTime = moment(startTimeStr, 'HH:mm');
        const endTime = moment(endTimeStr, 'HH:mm');

        if (!startTime.isValid() || !endTime.isValid()) return;

        // Default breakTime to 0 if null or undefined
        if (breakTime == null || isNaN(breakTime)) breakTime = 0;

        // Adjust for overnight shifts
        if (endTime.isBefore(startTime)) {
            endTime.add(1, 'days');
        }

        let totalHours = endTime.diff(startTime, 'hours', true); // Decimal
        totalHours -= parseFloat(breakTime);

        record.totalHours = totalHours.toFixed(2);

        if (!record.w2ui) record.w2ui = {};
        if (!record.w2ui.changes) record.w2ui.changes = {};
        record.w2ui.changes.totalHours = record.totalHours;

        grid.refreshRow(record.recid);
    }

    function toTimeSpanFormat(timeStr) {
        if (!timeStr) return "00:00";

        const parts = timeStr.split(':');
        const hours = parts[0].padStart(2, '0');
        const minutes = parts[1]?.padStart(2, '0') || '00';

        return `${hours}:${minutes}`;
    }


    function saveRecords() {
        const saveUrl = isTimeBased ? '/Attendance/SaveTimeAttendance' : '/Attendance/SaveJobAttendance';

        // Prepare the lists for inserts, updates, and deletes
        const insertList = [];
        const updateList = [];
        const deleteList = [];

        // Iterate over the grid records
        grid.records.forEach(record => {
            if (record._isNew) {
                // Insert: Rows marked as new (_isNew is true)
                insertList.push(mapRecord(record));
            } else if (record._isDeleted) {
                // Delete: Rows marked as deleted (_isDeleted is true)
                deleteList.push(record);
            } else if (record.w2ui?.changes && Object.keys(record.w2ui.changes).length > 0) {
                // Update: Rows with changes in w2ui.changes
                updateList.push(mapRecord(record));
            }
        });

        // If there are no records to save, exit early
        if (insertList.length === 0 && updateList.length === 0 && deleteList.length === 0) {
            alert("No changes to save.");
            return;
        }

        // Create the request data
        const requestData = {
            insertList,
            updateList,
            deleteList
        };
        console.log(requestData)
        // Send to the server
        $.ajax({
            url: saveUrl,
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            data: JSON.stringify(requestData),
            success: (res) => {
                console.log(res)
                if (res.success) {
                    alert("Saved successfully!");
                    location.reload();
                } else {
                    alert("Save failed: " + res.Message);
                }
            },
            error: (xhr, status, err) => alert("Error: " + err)
        });
    }
    function toUTCDateOnly(date) {
        const utcYear = date.getUTCFullYear();
        const utcMonth = String(date.getUTCMonth() + 1).padStart(2, '0'); // Months are 0-based
        const utcDate = String(date.getUTCDate()).padStart(2, '0');
        return `${utcYear}-${utcMonth}-${utcDate}`; // e.g., "2024-05-01"
    }

    // Helper function to map the record fields for insert/update
    function mapRecord(record) {
        const changes = record.w2ui?.changes || {};

        const getVal = (field, fallback) => {
            const val = changes[field] ?? record[field] ?? fallback;
            return val === undefined ? null : val;
        };

        return {
            RosterId: getVal('rosterId'),
            AttendanceDate: (getVal('attendanceDate')),
            StartTime: isTimeBased ? toTimeSpanFormat(getVal('startTime')) : undefined,
            EndTime: isTimeBased ? toTimeSpanFormat(getVal('endTime')) : undefined,
            TotalHours: isTimeBased ? getVal('totalHours') : null,
            BreakTime: isTimeBased ? (getVal('breakTime') ?? 0) : null,
            JobId: !isTimeBased ? getVal('jobId') : null,
            JobName: !isTimeBased ? getVal('jobName') : null,
            Quantity: !isTimeBased ? getVal('quantity') : null,
            Rate: !isTimeBased ? getVal('rate') : null,
            Amount: !isTimeBased ? getVal('amount') : null,
            Pay: getVal('pay'),
            AttendanceSignPic: record.attendanceSignPic?.substr(23) || '',
            BlockId: getVal('blockId'),
            LineId: getVal('lineId'),
            JobPaid: getVal('jobPaid') ? "Y" : "N",
            Remarks: getVal('remarks'),
            AppliedBy: currentUserId,
            ApprovedStatus: "P",
            ApprovedBy: getVal('approvedBy'),
            ApprovedDt: new Date()
        };

    }



    $(document).on('click', '.editBtn', function () {
        if (!isSupervisor) return;
        const recid = $(this).closest('tr').attr('recid');
        const record = grid.get(recid);
        const input = $('<input type="file" accept="image/*" style="display:none;">');
        input.on('change', e => {
            const file = e.target.files[0];
            const reader = new FileReader();
            reader.onload = evt => {
                record.attendanceSignPic = evt.target.result;
                grid.refresh();
            };
            reader.readAsDataURL(file);
        }).click();
    });

    $(document).on('click', '.viewBtn', function () {
        const recid = $(this).closest('tr').attr('recid');
        const record = grid.get(recid);
        if (!record.attendanceSignPic) return alert("No image to view");
        w2popup.open({
            title: 'Sign Image',
            width: 400,
            height: 400,
            body: `<img src="${record.attendanceSignPic}" style="width:100%;">`,
            actions: { Ok: w2popup.close }
        });
    });

    $('#tb_grid_toolbar_item_w2ui-reload').on('click', function () {
        grid.clear();
        grid.add(gridData);
        grid.refresh();
    });

    $.ajax({
        url: '/Attendance/GetUserAttendance',
        type: 'GET',
        success: function (data) {
            console.log(data);
            const timeBased = data.timeBased.map((item, index) => ({ recid: index + 1, ...item }));
            const jobBased = data.jobBased.map((item, index) => ({
                recid: index + 1 + timeBased.length,
                ...item
            }));

            gridData = isTimeBased ? timeBased : jobBased;

            // Calculate total hours for each record after data load
            gridData.forEach(record => {
                if (isTimeBased) {
                    calculateTotalHours(record);
                }
            });

            grid.clear();
            grid.add(gridData);
            grid.refresh();
        },
        error: function () {
            alert("Failed to load attendance data.");
        }
    });

});

/*$(document).ready(function () {
    const initialData = [
        {
            recid: 1,
            rosterId: 12345,
            attendanceDate: '1/1/2022',
            startTime: '08:00',
            endTime: '17:00',
            totalHours: 8.00,
            breakTime: 1.00,
            pay: 100.00,
            attendanceSignPic: '', // No image initially
            blockId: 2,
            lineId: 1,
            jobPaid: true,
            remarks: 'Worked the whole day',
            appliedBy: 'Manager1',
            approvedStatus: 1,
            approvedBy: 'Supervisor1',
            approvedDt: '1/2/2022'
        }
    ];

    let grid = new w2grid({
        name: 'grid',
        box: '#grid',
        show: {
            toolbar: true,
            footer: true,
            toolbarSave: false
        },
        columns: [
            { field: 'rosterId', text: 'Roster ID', size: '100px', sortable: true, resizable: true, editable: { type: 'text' }, info: true },
            { field: 'attendanceDate', text: 'Attendance Date', size: '120px', sortable: true, resizable: true, render: 'date', style: 'text-align: right', editable: { type: 'date' } },
            { field: 'startTime', text: 'Start Time', size: '100px', sortable: true, resizable: true, render: 'time', style: 'text-align: right', editable: { type: 'time' } },
            { field: 'endTime', text: 'End Time', size: '100px', sortable: true, resizable: true, render: 'time', style: 'text-align: right', editable: { type: 'time' } },
            { field: 'totalHours', text: 'Total Hours', size: '100px', sortable: true, resizable: true, render: 'int' },
            { field: 'breakTime', text: 'Break Time', size: '100px', sortable: true, resizable: true, render: 'int', editable: { type: 'float' } },
            { field: 'pay', text: 'Pay', size: '100px', sortable: true, resizable: true, render: 'money', editable: { type: 'money' } },
            {
                field: 'attendanceSignPic',
                text: 'Attendance Sign Pic',
                size: '200px',
                resizable: true,
                editable: { type: 'text' },
                render: function (record, index, column_index) {
                    if (!record.attendanceSignPic || record.attendanceSignPic === '') {
                        return ` 
                            <button class="editBtn">Edit</button>
                            <button class="viewBtn" disabled>View</button>
                        `;
                    }
                    return ` 
                        <button class="editBtn">Edit</button>
                        <button class="viewBtn">View</button>
                    `;
                }
            },
            { field: 'blockId', text: 'Block ID', size: '100px', sortable: true, resizable: true, editable: { type: 'int' } },
            { field: 'lineId', text: 'Line ID', size: '100px', sortable: true, resizable: true, editable: { type: 'int' } },
            { field: 'jobPaid', text: 'Job Paid', size: '100px', sortable: true, resizable: true, editable: { type: 'checkbox' } },
            { field: 'remarks', text: 'Remarks', size: '200px', sortable: true, resizable: true, editable: { type: 'text' } },
            { field: 'appliedBy', text: 'Applied By', size: '120px', sortable: true, resizable: true },
            { field: 'approvedStatus', text: 'Approved Status', size: '120px', sortable: true, resizable: true },
            { field: 'approvedBy', text: 'Approved By', size: '120px', sortable: true, resizable: true },
            { field: 'approvedDt', text: 'Approved Date', size: '120px', sortable: true, resizable: true, render: 'date', style: 'text-align: right' }
        ],
        toolbar: {
            items: [
                { id: 'add', type: 'button', text: 'Add Record', icon: 'w2ui-icon-plus' },
                { id: 'save', type: 'button', text: 'Save', icon: 'w2ui-icon-save' }  // Custom Save Button
            ],
            onClick(event) {
                if (event.target == 'add') {
                    let recid = grid.records.length + 1;
                    this.owner.add({ recid });
                    this.owner.scrollIntoView(recid);
                    this.owner.editField(recid, 1);
                }
                if (event.target == 'save') {
                    // Trigger the custom save logic when the "Save" button is clicked
                    saveRecords();
                }
            }
        },
        records: initialData,
        afterEditDone(index, column, event) {
            const record = w2ui['grid'].records[index];
            const field = column;

            console.log("edit");
            console.log(event);

            if (field === 3 || field === 5) {
                // Calculate total hours after editing start or end time
                calculateTotalHours(record, field);
            }
            //w2ui['grid'].refresh();
        }
    });

    // Custom save function
    function saveRecords() {
        const grid = w2ui['grid'];
        grid.save();
        const recordsToSave = grid.records;

        // Validation for empty required fields
        let invalidRecord = null;
        for (let record of recordsToSave) {
            if (!record.rosterId || !record.attendanceDate || !record.startTime || !record.endTime) {
                invalidRecord = record;
                break;
            }
        }

        if (invalidRecord) {
            alert('Roster ID, Attendance Date, Start Time, and End Time cannot be empty.');
            return;
        }

        let attendanceFormData = recordsToSave.map(record => ({
            RosterId: record.rosterId,
            AttendanceDate: new Date(record.attendanceDate).toISOString(),  // Ensure it is an ISO string
            StartTime: record.startTime,
            EndTime: record.endTime,
            TotalHours: record.totalHours,
            BreakTime: record.breakTime,
            Pay: record.pay,
            AttendanceSignPic: record.attendanceSignPic.substr(23) || '',
            BlockId: record.blockId,
            LineId: record.lineId,
            JobPaid: record.jobPaid == true? "Y" : "N",
            Remarks: record.remarks,
            AppliedBy: record.appliedBy,
            ApprovedStatus: "P",
            ApprovedBy: record.approvedBy,
            ApprovedDt: new Date(record.approvedDt).toISOString()  // Ensure it is an ISO string
        }));

        // Utility function to format time
        function formatTime(time) {
            if (time) {
                let date = new Date("1970-01-01T" + time + "Z");
                return date.toISOString().substr(11, 8); // Convert to "hh:mm:ss" format
            }
            return null;
        }

        let rootUrl = window.location.origin;

        $.ajax({
            url: '/Attendance/SaveTimeAttendance',  // Your controller action URL
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            data: JSON.stringify(attendanceFormData),  // Sending the data as JSON
            success: function (response) {
                if (response.Success) {
                    alert("Attendance records saved successfully!");
                    window.location.reload();
                } else {
                    alert("Failed to save attendance: " + response.Message);
                }
            },
            error: function (xhr, status, error) {
                alert("Error: " + error + "\nStatus: " + status);
            }
        });

    }




    // Calculate total hours
    function calculateTotalHours(record, field) {
        const startTime = (record.w2ui?.changes?.startTime
            ? moment(record.w2ui.changes.startTime, 'HH:mm')
            : moment(record.startTime, 'HH:mm'));
        const endTime = (record.w2ui?.changes?.endTime
            ? moment(record.w2ui.changes.endTime, 'HH:mm')
            : moment(record.endTime, 'HH:mm'));
        const breakTime = ((record.w2ui?.changes?.breakTime ? record.w2ui.changes.breakTime : record.breakTime)) || 0;

        if (startTime && endTime) {
            const start = moment(startTime, 'HH:mm');
            const end = moment(endTime, 'HH:mm');
            console.log(start);
            console.log(end);
            let totalHours = end.diff(start, 'hours', true); // Total hours as a decimal
            if (totalHours < 0) {
                totalHours += 24; // If the end time is after midnight, adjust by adding 24 hours
            }
            console.log(totalHours);
            record.w2ui = record.w2ui ?? {};
            record.w2ui.changes = record.w2ui.changes ?? {};
            record.w2ui.changes.totalHours = totalHours - breakTime; // Subtract break time
            
            grid.refresh();
        }
    }

    // Trigger file input when clicking the 'E' button (Edit)
    $(document).on('click', '.editBtn', function (event) {
        const recid = $(this).closest('tr').attr('recid');
        const grid = w2ui['grid'];
        const record = grid.get(recid);

        var input = document.createElement('input');
        input.type = 'file';
        input.accept = 'image/*';
        input.style.display = 'none';

        input.addEventListener('change', function (e) {
            if (e.target.files.length > 0) {
                var file = e.target.files[0];
                var reader = new FileReader();
                reader.onload = function (event) {
                    var base64Image = event.target.result;
                    record.attendanceSignPic = base64Image;
                    grid.refresh();
                };
                reader.readAsDataURL(file);
            }
        });

        input.click();
    });

    // View image on clicking the 'V' button (View)
    $(document).on('click', '.viewBtn', function (event) {
        const recid = $(this).closest('tr').attr('recid');
        const grid = w2ui['grid'];
        const record = grid.get(recid);

        if (!record.attendanceSignPic || record.attendanceSignPic === '') {
            alert('No image available');
            return;
        }

        w2popup.open({
            title: 'Attendance Sign Pic',
            width: 400,
            height: 400,
            body: `<img src="${record.attendanceSignPic}" style="width:100%; height:auto;" />`,
            actions: { Ok: w2popup.close }
        });
    });

    // Reload grid data logic
    $('#tb_grid_toolbar_item_w2ui-reload').on('click', function () {
        grid.clear();
        grid.add(initialData);
        grid.refresh();
    });
});
*/