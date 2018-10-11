### Preparation steps

1. Start mountebank [customer_service](https://github.com/thekaizokuou/mountebank_example). You can follow instruction from that Git.

2. Install python lib from requirement.txt
    ```bash
    pip install --upgrade -r requirement.txt
    ```

3. Prepare run folder to keep robot result.
   ```bash
   mkdir run
   cd run
   ```
   
4. Run robot by this command.
    ```bash
    pybot -v ENV:local testcases/
    ```