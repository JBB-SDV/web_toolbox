import os
from flask import render_template, jsonify, send_from_directory
from flask_appbuilder.models.sqla.interface import SQLAInterface
from flask_appbuilder import ModelView, ModelRestApi
from flask_appbuilder.security.decorators import has_access
from flask_appbuilder import expose, BaseView, AppBuilder
from flask_appbuilder.api import BaseApi, expose
import json
from flask_appbuilder import AppBuilder, BaseView, expose
from flask_wtf import FlaskForm
from wtforms import StringField
from wtforms.validators import DataRequired
from flask_appbuilder.widgets import FormWidget
from flask import request, render_template
import subprocess
import requests
from . import appbuilder, db




class IPForm(FlaskForm):
    ip_address = StringField("Adresse IP", validators=[DataRequired()])
    username = StringField("Username ", validators=[DataRequired()])
    password = StringField("Mot de passe", validators=[DataRequired()])

class rapport(BaseView):
    route_base = "/report"

    @expose('/method2/<string:param1>')
    @has_access
    def method2(self, param1):
        return f'Goodbye {param1}'

    @expose('/method4/')
    @has_access
    def method4(self):  
        self.update_redirect()
        return self.render_template('method4.html')

    @expose('/module1/', methods=['GET'])
    @has_access
    def display_json(self):
        api_url = "http://127.0.0.1:5000/api/v1/report/mod1/"
        
        try:
            response = requests.get(api_url)
            response.raise_for_status()  # Vérifie si la requête a réussi
            data = response.json()  # Convertit la réponse en JSON
        except requests.RequestException as e:
            data = {"error": f"Erreur lors de la récupération des données : {e}"}

        return self.render_template("mod1.html", data=data)
        
    @expose('/module1_target', methods=['GET', 'POST'])
    @has_access
    def index(self):
        form = IPForm(request.form)
        if request.method == 'POST' and form.validate():
            ip_address = form.ip_address.data
            self.display_ip(ip_address)  # Exécute le script avec l'adresse IP
        return self.render_template('lancement_mod1.html', form=form, base_template=appbuilder.base_template, appbuilder=appbuilder)
    
    
    @expose('/report_module1/', methods=['GET'])
    @has_access
    def get_json1(self):
        return self.render_template("report.html")    
    
    

class lancement_scan(BaseView):
    route_base = "/target"  # Définit un préfixe pour les routes de cette classe

    @expose('/parameters', methods=['GET', 'POST'])
    @has_access
    def index(self):
        return self.render_template('param_mod1.html')

    @expose('/module1_target', methods=['GET', 'POST'])
    @has_access
    def index(self):
        form = IPForm(request.form)
        if request.method == 'POST' and form.validate():
            ip_address = form.ip_address.data
            username = form.username.data
            password = form.password.data
            
            script_type = request.form.get("script_type")  # Récupère le type de script
            print(f"Valeur de script_type: {script_type}")

            print(username, password)
            
            
        #result = subprocess.run(['bash', 'app/module1/r0.sh'], capture_output=True, text=True)

            if script_type == "nosie":
                script_name = "app/module1/nosie/nosie.sh"
            else:
                script_name = "app/module1/sie/sie.sh"

            self.display_ip(ip_address, script_name, username, password)  # Passe le script en paramètre

        return self.render_template('lancement_mod1.html', form=form)


    def display_ip(self, ip_address, script_name, username, password):
        print(f"TARGET : {ip_address} - Script : {script_name}")

        try:
            result = subprocess.run(['bash', script_name, username, ip_address, password], capture_output=True, text=True)

            print(f"{result.stdout}")
            
            if result.stderr:
                print(f"Erreur ({script_name}): {result.stderr}")
                    
        except Exception as e:
            print(f"Erreur lors de l'exécution du script {script_name}: {str(e)}")



class FileListView(BaseView):
    route_base = "/logsmod1"

    @expose('/')
    @has_access
    def list_files(self):
        files_dir = os.path.join(os.path.dirname(__file__), 'module1', 'sie', 'output')
        files = os.listdir(files_dir)
        return self.render_template('logs_mod1.html', files=files)

    @expose('/download/<filename>')
    @has_access
    def download_file(self, filename):
        files_dir = os.path.join(os.path.dirname(__file__), 'module1', 'sie', 'output')
        return send_from_directory(files_dir, filename, as_attachment=True)



class MyApi(BaseApi):
    resource_name = "report"

    @expose('/json1/', methods=['GET'])
    @has_access
    def get_json1(self):
        return self._load_json_file("app/json/pouet.json")    
    

    
    @expose('/json2/', methods=['GET'])
    @has_access
    def get_json2(self):
        return self._load_json_file("app/json/pouet2.json")
    @expose('/mod1/', methods=['GET'])
    def get_json2(self):
        if request.remote_addr != "127.0.0.1":  # Bloque les requêtes externes
            return jsonify({"error": "Accès refusé"}), 403
        return self._load_json_file("app/json/mod1.json")

    def _load_json_file(self, filename):
        try:
            with open(filename, "r", encoding="utf-8") as f:
                data = json.load(f)
            return jsonify(data)
        except Exception as e:
            return jsonify({"error": str(e)}), 500

# Save les routes dans FAB
appbuilder.add_view_no_menu(rapport)
appbuilder.add_view_no_menu(lancement_scan)
appbuilder.add_view_no_menu(FileListView)

#appbuilder.add_link("Method2", href='/myview/method2/JB_le_BOSS', category='Methode 1/2')
appbuilder.add_link("Module 1", href='/report/module1', category='Résultat module')
appbuilder.add_link("Module 1 nbosie", href='/report/report_module1', category='Résultat module')
appbuilder.add_link("TEST", href='/report/method4', category='Résultat module')
appbuilder.add_link("Module 1 Lancement ", href='/target/module1_target', category='Lancement des modules')
appbuilder.add_link("Logs module 1 ", href='/logsmod1/', category='Gestion des logs modules')




appbuilder.add_api(MyApi)
appbuilder.add_link(
    "JSON1",  
    href="/api/v1/report/json1/",  
    category="APIs",  
    icon="fa-cloud"  
)
appbuilder.add_link(
    "JSON2",  
    href="/api/v1/report/json2/",  
    category="APIs",  
    icon="fa-cloud"  
)
appbuilder.add_link(
    "module1",  
    href="/api/v1/report/mod1/",  
    category="APIs",  
    icon="fa-cloud"  
)


@appbuilder.app.errorhandler(404)
def page_not_found(e):
    return render_template("404.html", base_template=appbuilder.base_template, appbuilder=appbuilder), 404
@appbuilder.app.errorhandler(500)
def page_not_found(e):
    return render_template("500.html", base_template=appbuilder.base_template, appbuilder=appbuilder), 500

db.create_all()
