import tkinter as tk
from tkinter import messagebox
import psycopg2
import os

conn = psycopg2.connect(
    dbname='aqc23qnu',
    user='aqc23qnu',
    password=os.getenv("DB_PASSWORD")
    host='cmpstudb-01.cmp.uea.ac.uk',
    port='5432'
)
cur = conn.cursor()
cur.execute("SET search_path TO demo, public;")

root = tk.Tk()
root.title("Database Systems")
root.geometry("680x500")

frame = tk.Frame(root)
frame.pack(pady=10)

tk.Label(frame, text="Student No:").grid(row=0, column=0)
entry_sno = tk.Entry(frame)
entry_sno.grid(row=0, column=1)

tk.Label(frame, text="Student Name:").grid(row=1, column=0)
entry_sname = tk.Entry(frame)
entry_sname.grid(row=1, column=1)

tk.Label(frame, text="Student Email:").grid(row=2, column=0)
entry_semail = tk.Entry(frame)
entry_semail.grid(row=2, column=1)

tk.Label(frame, text="Exam Code:").grid(row=0, column=2)
entry_excode = tk.Entry(frame)
entry_excode.grid(row=0, column=3)

tk.Label(frame, text="Exam Title:").grid(row=1, column=2)
entry_extitle = tk.Entry(frame)
entry_extitle.grid(row=1, column=3)

tk.Label(frame, text="Exam Location:").grid(row=2, column=2)
entry_exlocation = tk.Entry(frame)
entry_exlocation.grid(row=2, column=3)

tk.Label(frame, text="Exam Date (DD-MM-YYYY):").grid(row=3, column=2)
entry_exdate = tk.Entry(frame)
entry_exdate.grid(row=3, column=3)

tk.Label(frame, text="Exam Time (HH:MM):").grid(row=4, column=2)
entry_extime = tk.Entry(frame)
entry_extime.grid(row=4, column=3)

tk.Label(frame, text="Entry No:").grid(row=5, column=0)
entry_eno = tk.Entry(frame)
entry_eno.grid(row=5, column=1)

tk.Label(frame, text="Grade:").grid(row=5, column=2)
entry_grade = tk.Entry(frame)
entry_grade.grid(row=5, column=3)

output_box = tk.Text(root, width=80, height=12)
output_box.pack(pady=10)


def task_a():
    try:
        cur.execute("INSERT INTO student (sno, sname, semail) VALUES (%s, %s, %s)",
                    (entry_sno.get(), entry_sname.get(), entry_semail.get()))
        conn.commit()
        output_box.insert(tk.END, "Student added.\n")
    except Exception as e:
        conn.rollback()
        messagebox.showerror("Error", str(e))


def task_b():
    try:
        cur.execute("INSERT INTO exam (excode, extitle, exlocation, exdate, extime) VALUES (%s, %s, %s, %s, %s)",
                    (entry_excode.get(),
                     entry_extitle.get(),
                     entry_exlocation.get(),
                     entry_exdate.get(),
                     entry_extime.get()))
        conn.commit()
        output_box.insert(tk.END, "Exam added.\n")
    except Exception as e:
        conn.rollback()
        messagebox.showerror("Error", str(e))


def task_c():
    try:
        sno = entry_sno.get()
        cur.execute("INSERT INTO cancel (eno, excode, sno, cdate, cuser) SELECT eno, excode, sno, current_timestamp, 'admin' FROM entry WHERE sno = %s", (sno,))
        cur.execute("DELETE FROM entry WHERE sno = %s", (sno,))
        cur.execute("DELETE FROM student WHERE sno = %s", (sno,))
        conn.commit()
        output_box.insert(tk.END, f"Student {sno} deleted and entries cancelled.\n")
    except Exception as e:
        conn.rollback()
        messagebox.showerror("Error", str(e))


def task_d():
    try:
        excode = entry_excode.get()
        cur.execute("SELECT 1 FROM entry WHERE excode = %s AND eno NOT IN (SELECT eno FROM cancel)", (excode,))
        if cur.fetchone():
            output_box.insert(tk.END, f"Exam {excode} has active entries and cannot be deleted.\n")
        else:
            cur.execute("DELETE FROM exam WHERE excode = %s", (excode,))
            conn.commit()
            output_box.insert(tk.END, f"Exam {excode} deleted.\n")
    except Exception as e:
        conn.rollback()
        messagebox.showerror("Error", str(e))


def task_e():
    try:
        cur.execute("INSERT INTO entry (eno, excode, sno) VALUES (%s, %s, %s)",
                    (entry_eno.get(), entry_excode.get(), entry_sno.get()))
        conn.commit()
        output_box.insert(tk.END, "Exam entry added.\n")
    except Exception as e:
        conn.rollback()
        messagebox.showerror("Error", str(e))


def task_f():
    try:
        cur.execute("UPDATE entry SET egrade = %s WHERE eno = %s",
                    (entry_grade.get(), entry_eno.get()))
        conn.commit()
        output_box.insert(tk.END, "Grade updated.\n")
    except Exception as e:
        conn.rollback()
        messagebox.showerror("Error", str(e))


def task_g():
    try:
        sno = entry_sno.get()
        cur.execute("SELECT s.sname, ex.excode, ex.extitle, ex.exlocation, ex.exdate, ex.extime\n                     FROM entry e\n                     JOIN student s ON e.sno = s.sno\n                     JOIN exam ex ON e.excode = ex.excode\n                     WHERE s.sno = %s ORDER BY ex.exdate", (sno,))
        results = cur.fetchall()
        output_box.insert(tk.END, f"\nTimetable for student {sno}:\n")
        for row in results:
            output_box.insert(tk.END, f"{row}\n")
    except Exception as e:
        messagebox.showerror("Error", str(e))


def task_h():
    try:
        cur.execute("SELECT e.excode, ex.extitle, s.sname,\n                     CASE\n                       WHEN e.egrade IS NULL THEN 'Not taken'\n                       WHEN e.egrade >= 70 THEN 'Distinction'\n                       WHEN e.egrade >= 50 THEN 'Pass'\n                       ELSE 'Fail'\n                     END AS result\n                     FROM entry e\n                     JOIN student s ON e.sno = s.sno\n                     JOIN exam ex ON e.excode = ex.excode\n                     ORDER BY e.excode, s.sname")
        results = cur.fetchall()
        output_box.insert(tk.END, "\nAll Student Results:\n")
        for row in results:
            output_box.insert(tk.END, f"{row}\n")
    except Exception as e:
        messagebox.showerror("Error", str(e))


def task_i():
    try:
        excode = entry_excode.get()
        cur.execute("SELECT e.excode, ex.extitle, s.sname,\n                     CASE\n                       WHEN e.egrade IS NULL THEN 'Not taken'\n                       WHEN e.egrade >= 70 THEN 'Distinction'\n                       WHEN e.egrade >= 50 THEN 'Pass'\n                       ELSE 'Fail'\n                     END AS result\n                     FROM entry e\n                     JOIN student s ON e.sno = s.sno\n                     JOIN exam ex ON e.excode = ex.excode\n                     WHERE e.excode = %s ORDER BY s.sname", (excode,))
        results = cur.fetchall()
        output_box.insert(tk.END, f"\nResults for exam {excode}:\n")
        for row in results:
            output_box.insert(tk.END, f"{row}\n")
    except Exception as e:
        messagebox.showerror("Error", str(e))


frame_buttons = tk.Frame(root)
frame_buttons.pack(pady=10)

tk.Button(frame_buttons, text="Add Student (A)", command=task_a).grid(row=0, column=0)
tk.Button(frame_buttons, text="Add Exam (B)", command=task_b).grid(row=0, column=1)
tk.Button(frame_buttons, text="Delete Student (C)", command=task_c).grid(row=0, column=2)
tk.Button(frame_buttons, text="Delete Exam (D)", command=task_d).grid(row=1, column=0)
tk.Button(frame_buttons, text="Add Entry (E)", command=task_e).grid(row=1, column=1)
tk.Button(frame_buttons, text="Update Grade (F)", command=task_f).grid(row=1, column=2)
tk.Button(frame_buttons, text="Show Timetable (G)", command=task_g).grid(row=2, column=0)
tk.Button(frame_buttons, text="Show All Results (H)", command=task_h).grid(row=2, column=1)
tk.Button(frame_buttons, text="Show Exam Results (I)", command=task_i).grid(row=2, column=2)


root.mainloop()
